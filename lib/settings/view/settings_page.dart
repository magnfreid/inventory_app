import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';
import 'package:inventory_app/theme/models/app_seed_color.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static MaterialPageRoute<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsPageTitle),
      ),
      body: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(l10n.settingsThemeModeTitle, style: context.text.titleMedium),
        const SizedBox(height: 12),
        const _ThemeModeSelector(),
        const SizedBox(height: 24),
        Text(l10n.settingsSeedColorTitle, style: context.text.titleMedium),
        const SizedBox(height: 12),
        const _SeedColorSelector(),
        const Divider(height: 32),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.query_stats),
          title: Text(l10n.settingsStatisticsLinkText),
          onTap: () =>
              unawaited(Navigator.push(context, StatisticsPage.route())),
        ),
      ],
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final mode = context.watch<ThemeCubit>().state.mode;
    return SegmentedButton<AppThemeMode>(
      segments: [
        ButtonSegment<AppThemeMode>(
          value: AppThemeMode.system,
          icon: const Icon(Icons.mobile_friendly),
          label: Text(l10n.settingsThemeModeSystem),
        ),
        ButtonSegment<AppThemeMode>(
          value: AppThemeMode.light,
          icon: const Icon(Icons.light_mode),
          label: Text(l10n.settingsThemeModeLight),
        ),
        ButtonSegment<AppThemeMode>(
          value: AppThemeMode.dark,
          icon: const Icon(Icons.dark_mode),
          label: Text(l10n.settingsThemeModeDark),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) =>
          context.read<ThemeCubit>().setMode(selection.first),
    );
  }
}

class _SeedColorSelector extends StatelessWidget {
  const _SeedColorSelector();

  String _label(AppSeedColor seedColor, AppLocalizations l10n) {
    switch (seedColor) {
      case AppSeedColor.blueGrey:
        return l10n.settingsSeedColorBlueGrey;
      case AppSeedColor.teal:
        return l10n.settingsSeedColorTeal;
      case AppSeedColor.deepPurple:
        return l10n.settingsSeedColorDeepPurple;
      case AppSeedColor.orange:
        return l10n.settingsSeedColorOrange;
      case AppSeedColor.green:
        return l10n.settingsSeedColorGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedColor = context.watch<ThemeCubit>().state.seedColor;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: AppSeedColor.values.map((seedColor) {
        final isSelected = seedColor == selectedColor;
        return Tooltip(
          message: _label(seedColor, l10n),
          child: GestureDetector(
            onTap: () => context.read<ThemeCubit>().setSeedColor(seedColor),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: seedColor.color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: context.colors.onSurface,
                        width: 3,
                      )
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 24)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
