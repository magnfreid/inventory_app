# Future features

Concrete implementation plans for each item live in [PLANS.md](PLANS.md).

## Snackbar notification system
Replace the current plain-text error snackbar with a rich, styled, app-wide
notification system. Add success snackbars alongside error snackbars, with
clear visual distinction between types. Designed to be extended with additional
message types (e.g. info, warning) in the future. Reachable via
`context.showSuccessSnackBar(message)` / `context.showErrorSnackBar(exception)`
from any widget that has a `ScaffoldMessenger` ancestor.

## Share part info
Add the ability to share basic part information — name, detail number, brand,
category, description, and current stock per storage — as either plain text or
a formatted PDF. Images should be excluded from the share payload. The feature
should be reachable from the part details screen (dot menu) and use the platform's native
share sheet.

## Improve web / large-screen layout
The desktop-width web layout needs polish:
- Consider replacing the drawer menu with a navigation rail (or a permanent
  side navigation bar once Flutter supports it well).
- Add horizontal padding or a maximum content width to list items and detail
  views so they don't stretch across the full screen width.
