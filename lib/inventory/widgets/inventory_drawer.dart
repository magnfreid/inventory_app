import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';

class InventoryDrawer extends StatelessWidget {
  const InventoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final l10n = context.l10n;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Align(
                alignment: .bottomLeft,
                child: Text(l10n.drawerHeaderText),
              ),
            ),
            SegmentedButton<ThemeMode>(
              style: SegmentedButton.styleFrom(),
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: .system,
                  icon: Icon(Icons.system_security_update),
                ),
                ButtonSegment<ThemeMode>(
                  value: .light,
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: .dark,
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) => context
                  .read<ThemeCubit>()
                  .themeButtonPressed(selection.first),
            ),

            ListTile(
              leading: const Icon(Icons.shelves),
              title: Text(l10n.drawerLocationsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, StoragesPage.route()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.query_stats),
              title: Text(l10n.drawerStatisticsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, StatisticsPage.route()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.drawerSettingsLinkText),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(l10n.drawerSignOutActionText),
              onTap: () => context.read<AuthenticationCubit>().signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
