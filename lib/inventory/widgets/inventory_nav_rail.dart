import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/l10n/l10n.dart';

/// Permanent navigation rail shown on wide-screen layouts.
///
/// Highlights the [selectedIndex] destination and fires
/// [onDestinationSelected] when the user taps a rail item. Destinations
/// mirror the drawer items used in the compact layout.
class InventoryNavRail extends StatelessWidget {
  /// Creates an [InventoryNavRail].
  const InventoryNavRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Called when the user selects a destination.
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return NavigationRail(
      selectedIndex: selectedIndex,
      labelType: .all,
      onDestinationSelected: onDestinationSelected,
      trailing: Expanded(
        child: Align(
          alignment: .bottomCenter,
          child: Padding(
            padding: const .only(bottom: 16),
            child: IconButton(
              icon: const Icon(Icons.logout),
              tooltip: l10n.drawerSignOutActionText,
              onPressed: () => context.read<AuthenticationCubit>().signOut(),
            ),
          ),
        ),
      ),
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.inventory_2),
          label: Text(l10n.drawerInventoryLinkText),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.shelves),
          label: Text(l10n.drawerLocationsLinkText),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.sell),
          label: Text(l10n.drawerTagsLinkText),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.history),
          label: Text(l10n.drawerStatisticsLinkText),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.settings),
          label: Text(l10n.drawerSettingsLinkText),
        ),
      ],
    );
  }
}
