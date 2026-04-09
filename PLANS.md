# Implementation plans

Concrete step-by-step plans for the features listed in TODO.md.
Each plan is scoped to what needs to change and where.

---

## Storage transfer

### Background
Transfers require two atomic stock mutations (deduct from source, add to
destination) plus two transaction log entries, all in a single Firestore
transaction. The existing `applyStockChange` method is single-storage only, so
a dedicated remote method is needed. To keep the transaction log meaningful,
`TransactionDto` needs to carry a destination storage for transfer entries.

### Data layer — `packages/`

**1. `stock_remote` — extend `TransactionType` enum**

Add `.transfer` to the existing `TransactionType` enum in
`packages/stock_remote/lib/src/models/transaction_dto.dart`.
Update JSON serialization so `"transfer"` round-trips correctly.

**2. `stock_remote` — add destination field to `TransactionDto`**

Add a nullable `String? destinationStorageId` field to `TransactionDto`.
Only transfer transactions will set this; use/restock/adjustment leave it null.
Update `fromJson`/`toJson` accordingly.

**3. `stock_repository` — extend `Transaction` domain model**

Add `String? destinationStorageId` to the `Transaction` model in
`packages/stock_repository/lib/src/models/transaction.dart`.

Add a named constructor `Transaction.transfer(...)` that:
- Sets `type = .transfer`
- Sets `amount` to the transferred quantity (positive)
- Sets both `storageId` (source) and `destinationStorageId`
- Accepts the usual snapshot fields (partName, storageName, etc.) plus
  `destinationStorageName`

**4. `stock_remote` — add `transferStock` to the abstract interface**

Add to `StockRemote` (`packages/stock_remote/lib/src/stock_remote.dart`):

```dart
Future<void> transferStock({
  required TransactionDto deductTransaction,
  required TransactionDto addTransaction,
});
```

The two DTOs are already fully formed by the repository; the remote just
writes them atomically.

**5. `firebase_stock_remote` — implement `transferStock`**

In `FirebaseStockRemote`, implement `transferStock` using a single
`firestore.runTransaction()` that:
1. Reads source stock doc (`{partId}_{fromStorageId}`)
2. Reads destination stock doc (`{partId}_{toStorageId}`)
3. Validates source quantity >= transfer amount (throw
   `InvalidArgumentRemoteException` otherwise)
4. Writes updated source stock (decreased), updated destination stock
   (increased), and both transaction documents — all in one commit

**6. `stock_repository` — add `transferStock` to the repository**

Add `transferStock(...)` to `StockRepository` following the same pattern as
`useStock`/`restockStock`. It constructs the two `TransactionDto`s from the
`Transaction.transfer(...)` domain object and calls
`_remote.transferStock(...)`.

### UI layer — `lib/`

**7. `part_details` Bloc — add event and handler**

Add `TransferStockButtonPressed` event to
`lib/part_details/bloc/part_details_event.dart` with fields:
`fromStorageId`, `toStorageId`, `quantity`, `userId`, `userDisplayName`,
`note` (optional).

Register a `droppable()` handler `_onTransferStockButtonPressed` in
`PartDetailsBloc` that calls `_stockRepository.transferStock(...)`, mirrors
the error handling of the existing `_onAddToStockButtonPressed`.

**8. `part_details` UI — add entry point**

The most natural entry point is the in-stock tab (same place the "Use" button
lives), since the user needs to see current stock per storage before choosing
where to transfer from. Add a "Transfer" button alongside "Use" in the
in-stock row, or add it as an action in `PartDetailsPopUpMenu` — either works,
but in-stock row is more discoverable.

**9. `part_details` — create `TransferSheet`**

Model on the existing `RestockSheet` (two-stage nested Navigator).
Three stages:
1. **Source storage selector** — list only storages where `quantity > 0`
2. **Destination storage selector** — list all storages except source
3. **Quantity selector** — increment/decrement stepper bounded between
   1 and source quantity; optional note field

On confirm, dispatch `TransferStockButtonPressed`. Listen on `stockStatus`
(same `.done` pattern as other sheets) to close and show confirmation.

**10. Localization**

Add ARB keys for all new UI strings (sheet titles, button labels, validation
messages) in both `app_en.arb` and `app_sv.arb`. Run `flutter gen-l10n`.

---

## Share part info

### Background
`PartPresentation` (already in Bloc state) contains everything needed:
name, detail number, price, description, isRecycled, and
`List<StockPresentation>` which already carries resolved storage names and
quantities. No new data fetching is required. No PDF for now — plain text
via the platform share sheet is sufficient and keeps the feature simple.

### Dependencies

**1. Add `share_plus` to `pubspec.yaml`**

```yaml
share_plus: ^10.0.0
```

Run `flutter pub get`.

### UI layer — `lib/`

**2. `part_details` — add share action to pop-up menu**

In `lib/part_details/widgets/part_details_pop_up_menu.dart`, add a `.share`
value to the `_MenuAction` enum and a corresponding `PopupMenuItem`. In the
switch, call a helper that reads the current `PartPresentation` from Bloc
state and triggers the share.

No new Bloc event is needed — sharing is a purely local, synchronous UI
action. Read the part from `context.read<PartDetailsBloc>().state.part`
directly in the callback.

**3. Create a `_sharePartAsText` helper function**

Add a private function (or static method on a small `ShareFormatter` class if
you want it testable) that takes a `PartPresentation` and returns a formatted
`String`:

```
[name] — [detailNumber]
[description if present]

Price: [price]
Recycled part: Yes/No

Stock
  [storageName]: [qty] pcs
  [storageName]: [qty] pcs
Total: [totalQuantity] pcs
```

Call `SharePlus.instance.share(ShareParams(text: text, subject: part.name))`
from the pop-up menu callback.

**4. Localization**

Add ARB keys for the menu item label and any UI strings in both ARB files.
Run `flutter gen-l10n`.

---

## Web / large-screen layout

### Background
The app currently uses a `Drawer` on all screen sizes and no width constraints
on list content. On a wide desktop browser, this means the parts list items
stretch across the full viewport and the navigation requires opening a drawer.
The plan avoids a router refactor — the existing `Navigator.push` pattern is
kept as-is. Only the shell layout changes.

### Approach

Use a `LayoutBuilder` (or a single breakpoint constant) to distinguish between
compact (< 600 px) and expanded (≥ 600 px) layouts. On expanded, swap the
`Drawer` for a permanent `NavigationRail` on the left of the `InventoryPage`
body and add a max-width constraint to the content column.

### Steps

**1. Introduce a breakpoint constant**

Add a single constant (e.g. `kExpandedBreakpoint = 600.0`) somewhere shared,
such as `lib/shared/constants/layout.dart`, to avoid magic numbers.

**2. Refactor `InventoryPage` Scaffold for large screens**

In `lib/inventory/view/inventory_page.dart`, wrap the Scaffold body in a
`LayoutBuilder`. On expanded widths, render a `Row` with:
- A `NavigationRail` (permanent, no hamburger) that replicates the drawer
  destinations (Storages, Tags, Statistics, Settings, Sign out)
- A `VerticalDivider`
- An `Expanded` child containing the existing list content

On compact widths, keep the existing `Drawer` behaviour unchanged.

The `NavigationRail` destinations map 1-to-1 with the existing
`InventoryDrawer` `ListTile`s. Navigation callbacks stay identical
(`Navigator.push(...)`) — the rail just replaces the trigger widget, not
the navigation model.

**3. Retire `InventoryDrawer` on large screens**

Pass `drawer: null` to the Scaffold when expanded, or gate the
`drawer:` parameter on the breakpoint check so the swipe-to-open drawer
is only present in compact mode.

**4. Constrain list content width**

In the expanded layout, wrap the parts list (the `ListView.builder` / `SliverList` in `InventoryPage`) in a `Center` with a `ConstrainedBox(maxWidth: 900)` so items don't span the full screen. This also benefits tablet-sized windows.

**5. `InventoryPartCard` — no changes required**

The card itself does not need changes. The width constraint applied to the
list container is enough.

**6. Other full-screen pages (StoragesPage, TagsPage, etc.)**

These are pushed on top of InventoryPage via Navigator and each has their own
Scaffold. Apply the same max-width constraint to their list bodies in a
follow-up pass. Keep this out of scope for the initial landing.
