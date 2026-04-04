import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/settings/settings.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_app/tags/view/tags_page.dart';

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
            ListTile(
              leading: const Icon(Icons.shelves),
              title: Text(l10n.drawerLocationsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, StoragesPage.route()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.sell),
              title: Text(l10n.drawerTagsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, TagsPage.route()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.drawerSettingsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, SettingsPage.route()));
              },
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
