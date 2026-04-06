# Inventory app — architecture and AI behavior

## UI state: Bloc

- Use **Bloc** (or Cubit where appropriate) for screen and feature UI state, not ad-hoc `setState` for business/async state.
- Prefer `BlocProvider`, `BlocBuilder` / `BlocListener`, and repository injection patterns already used in the app.

## Page + View in one file

- For a feature screen, **normally** split in the **same file**:
  - **`*Page`**: provides the Bloc (`BlocProvider`), may own `Scaffold` / `AppBar`, reads repositories from `context` and passes them into the Bloc constructor.
  - **`*View`**: child widget that contains **UI only** (`BlocBuilder`, layout, navigation callbacks).
- Example: `StatisticsPage` → provides `StatisticsBloc` → child `StatisticsView` with the rest of the UI.

## Packages layout

- **Repositories, remotes, services**, and similar integration code live under **`packages/`** (not under `lib/`). The app layer in `lib/` composes them.

## Code organization

- Prefer **clear folder boundaries** (e.g. `feature/bloc/`, `feature/view/`) and names that match navigation and responsibility so the codebase is **easy to scan**.

## Dart dot shorthands

- Prefer **leading-dot enum / static member shorthand** where Dart can infer the
  type (same style as elsewhere in this repo), e.g. `.center` instead of
  `MainAxisAlignment.center`, `.loaded` instead of `StatisticsStatus.loaded`
  when the target type is clear from context.
- Skip shorthand when inference fails, the code becomes unclear, or you need to
  disambiguate two types with the same member name.

## Localization (l10n)

- **Do not hardcode** user-visible strings in widgets (labels, buttons, tooltips,
  empty states, errors shown in the UI). Use the app's generated
  **localizations** (`context.l10n` / `AppLocalizations`).
- When adding or changing UI copy, update **both** ARB files:
  - `lib/l10n/arb/app_en.arb` (English)
  - `lib/l10n/arb/app_sv.arb` (Swedish)
- Use the same **message key** in both files; keep Swedish and English
  **meaning aligned** (same placeholders / plural rules where applicable).
- After ARB edits, run **`flutter gen-l10n`** (or the project's `melos` l10n
  script) so generated Dart code stays in sync.

## Documentation

- Add **`///` documentation comments** to **all public** APIs: classes, constructors, methods, getters, top-level declarations, and public enum values where they are part of the contract.
- Wrap **`///` doc comments and `//` comments** so each line is **at most 80 characters** (break long sentences across lines; indent continuation lines to match the project style).

## Clarification

- **Ask the user** when requirements are ambiguous (e.g. product behavior, Firestore shape, or UX) instead of guessing.
