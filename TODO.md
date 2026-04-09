# Future features

Concrete implementation plans for each item live in [PLANS.md](PLANS.md).

## Storage transfer
Add the ability to transfer a part between two storages. This requires new
infrastructure (repository method, remote data source) as well as a UI entry
point — likely from the part's in-stock view or a storage-scoped action.
Transfers must be recorded as a dedicated transaction type (distinct from
ordinary use/restock entries) so that they can be identified correctly in the
statistics and transaction history without skewing consumption or replenishment
data.

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
