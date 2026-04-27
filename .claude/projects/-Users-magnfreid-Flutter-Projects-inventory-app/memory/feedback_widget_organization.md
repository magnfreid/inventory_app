---
name: Widget file organization
description: Rule for when to extract widgets into separate files under the /widgets folder
type: feedback
---

Only very small helper widgets belong as private classes in the same file as the page/view.
Anything substantial should live in its own file under the feature's `widgets/` folder (e.g.
`lib/inventory/widgets/`), named with the feature prefix.

**Why:** The page file was getting long and hard to scan. The user explicitly defined this rule
after seeing `inventory_page.dart` grow to 460 lines with four embedded private widget classes.

**How to apply:** When adding a widget to a feature, default to a new file in `feature/widgets/`.
Only keep it private in the same file if it is a trivial, single-purpose wrapper (< ~20 lines)
that would not benefit from being independently discoverable.
