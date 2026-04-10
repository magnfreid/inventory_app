# Implementation plans

Concrete step-by-step plans for the features listed in TODO.md.
Each plan is scoped to what needs to change and where.

---

## Snackbar notification system

### Background
The app currently has a single `showErrorSnackBar(Exception)` extension method
that renders an unstyled `SnackBar` with plain text. There is no positive
feedback when operations succeed. The new system introduces a styled,
icon-accompanied snackbar with at minimum two semantic types — **error** and
**success** — and an architecture that makes adding further types (e.g. info,
warning) a one-line change.

### Architecture overview

The public surface is two extension methods on `BuildContext`:

```dart
context.showSuccessSnackBar(String message);
context.showErrorSnackBar(Exception exception);
```

Both delegate to a single private `_showAppSnackBar` helper that resolves
visual styling from a `SnackBarType` → `_SnackBarConfig` mapping. Adding a
new type only requires:
1. One new enum value.
2. One new case in the config factory.
3. One new public extension method.

No call sites need to change when a new type is added.

### Step 1 — `SnackBarType` enum

Create `lib/shared/widgets/app_snack_bar.dart`. Define:

```dart
/// Semantic category of an app-wide snackbar notification.
enum SnackBarType {
  /// Indicates a successful operation.
  success,

  /// Indicates a failed or erroneous operation.
  error,
}
```

Keep this file as the single source of truth for snackbar styling so all
future types are added in one place.

### Step 2 — `_SnackBarConfig` internal data class

In the same file, add a private immutable config class:

```dart
class _SnackBarConfig {
  const _SnackBarConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    this.duration = const Duration(seconds: 3),
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final Duration duration;

  factory _SnackBarConfig.of(SnackBarType type, ColorScheme scheme) {
    return switch (type) {
      SnackBarType.success => _SnackBarConfig(
          backgroundColor: const Color(0xFFD4EDD4),
          foregroundColor: const Color(0xFF1A4D1A),
          icon: Icons.check_circle_outline,
        ),
      SnackBarType.error => _SnackBarConfig(
          backgroundColor: scheme.errorContainer,
          foregroundColor: scheme.onErrorContainer,
          icon: Icons.error_outline,
        ),
    };
  }
}
```

**Notes on color choices:**
- **Error** uses `colorScheme.errorContainer` / `onErrorContainer` — these are
  already seeded by the app's dynamic theme and are guaranteed to be legible.
- **Success** uses fixed green tones that are visually distinct and readable
  regardless of the seed color. If the app later gains a dedicated success
  seed color, only the factory case needs to change.
- The `duration` field exists so individual types (or future call sites) can
  override persistence length if needed.

### Step 3 — private `_showAppSnackBar` helper

Also in `app_snack_bar.dart`:

```dart
void _showAppSnackBar(
  BuildContext context,
  String message,
  SnackBarType type,
) {
  final config = _SnackBarConfig.of(
    type,
    Theme.of(context).colorScheme,
  );
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        backgroundColor: config.backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: config.duration,
        content: Row(
          children: [
            Icon(config.icon, color: config.foregroundColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: config.foregroundColor),
              ),
            ),
          ],
        ),
      ),
    );
}
```

`clearSnackBars()` before showing prevents stacking when the user triggers
multiple operations quickly.

### Step 4 — replace the extension in `show_snack_bar_extensions.dart`

Replace the current `ShowSnackBar` extension body with:

```dart
import 'package:core_remote/core_remote.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/widgets/app_snack_bar.dart';

extension ShowSnackBar on BuildContext {
  /// Shows a success snackbar with [message].
  void showSuccessSnackBar(String message) =>
      _showAppSnackBar(this, message, .success);

  /// Shows an error snackbar. [exception] is mapped to a localized
  /// string if it is a [RemoteException]; otherwise falls back to
  /// [Exception.toString].
  void showErrorSnackBar(Exception exception) {
    final message = exception is RemoteException
        ? exception.toL10n(this)
        : exception.toString();
    _showAppSnackBar(this, message, .error);
  }
}
```

All existing `showErrorSnackBar` call sites continue to work unchanged since
the signature is identical.

### Step 5 — add success feedback at call sites

Existing `BlocListener`s that already handle the `.done` state need a
`showSuccessSnackBar` call added. Candidate locations:

| Feature | Listener location | Suggested message ARB key |
|---|---|---|
| Use stock | `UseStockSheet` done-listener | `snackbarStockUsed` |
| Restock | `RestockSheet` done-listener | `snackbarStockRestocked` |
| Transfer | `TransferSheet` done-listener | `snackbarStockTransferred` |
| Edit part | `PartEditorPage` done-listener | `snackbarPartSaved` |
| Delete part | `PartDetailsView` delete-listener | *(no success message needed — page pops)* |
| Upload / delete image | `PartDetailsView` image-listener | `snackbarImageUpdated` |

**Decision point:** Messages can be generic (e.g. a single `snackbarSuccess`
key reused everywhere) or operation-specific (one key per action). The table
above assumes operation-specific, which gives users clearer feedback. Choose
before implementation and update the ARB files accordingly.

### Step 6 — localization

Add ARB keys for each success message (or a single generic one if preferred)
to both `app_en.arb` and `app_sv.arb`. Run `flutter gen-l10n`.

Example keys (operation-specific):
```json
"snackbarStockUsed": "Stock updated.",
"snackbarStockRestocked": "Stock restocked.",
"snackbarStockTransferred": "Transfer complete.",
"snackbarPartSaved": "Part saved.",
"snackbarImageUpdated": "Image updated."
```

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

In the expanded layout, wrap the parts list (the `ListView.builder` /
`SliverList` in `InventoryPage`) in a `Center` with a
`ConstrainedBox(maxWidth: 900)` so items don't span the full screen.
This also benefits tablet-sized windows.

**5. `InventoryPartCard` — no changes required**

The card itself does not need changes. The width constraint applied to the
list container is enough.

**6. Other full-screen pages (StoragesPage, TagsPage, etc.)**

These are pushed on top of InventoryPage via Navigator and each has their own
Scaffold. Apply the same max-width constraint to their list bodies in a
follow-up pass. Keep this out of scope for the initial landing.
