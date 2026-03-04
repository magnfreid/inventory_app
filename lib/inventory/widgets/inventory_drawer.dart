import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_app/tags/view/tags_page.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';

class InventoryDrawer extends StatelessWidget {
  const InventoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            const _ThemeModeSelector(),

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
              leading: const Icon(Icons.tag),
              title: const Text('Handle tags'),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, TagsPage.route()));
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

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;
    return SegmentedButton<AppThemeMode>(
      style: SegmentedButton.styleFrom(),
      segments: const [
        ButtonSegment<AppThemeMode>(
          value: .system,
          icon: Icon(Icons.system_security_update),
        ),
        ButtonSegment<AppThemeMode>(
          value: .light,
          icon: Icon(Icons.light_mode),
        ),
        ButtonSegment<AppThemeMode>(
          value: .dark,
          icon: Icon(Icons.dark_mode),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) =>
          context.read<ThemeCubit>().themeButtonPressed(selection.first),
    );
  }
}
