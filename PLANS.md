# Implementation plans

Concrete step-by-step plans for the features listed in TODO.md.
Each plan is scoped to what needs to change and where.

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

**1. Introduce a breakpoint constant** ✅

Add a single constant (e.g. `kExpandedBreakpoint = 600.0`) somewhere shared,
such as `lib/shared/constants/layout.dart`, to avoid magic numbers.

**2. Refactor `InventoryPage` Scaffold for large screens** ✅

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

**3. Retire `InventoryDrawer` on large screens** ✅

Pass `drawer: null` to the Scaffold when expanded, or gate the
`drawer:` parameter on the breakpoint check so the swipe-to-open drawer
is only present in compact mode.

**4. Constrain list content width** ✅

In the expanded layout, wrap the parts list (the `ListView.builder` /
`SliverList` in `InventoryPage`) in a `Center` with a
`ConstrainedBox(maxWidth: 900)` so items don't span the full screen.
This also benefits tablet-sized windows.

**5. `InventoryPartCard` — no changes required** ✅

The card itself does not need changes. The width constraint applied to the
list container is enough.

**6. Other full-screen pages (StoragesPage, TagsPage, etc.)**

These are pushed on top of InventoryPage via Navigator and each has their own
Scaffold. Apply the same max-width constraint to their list bodies in a
follow-up pass. Keep this out of scope for the initial landing.
