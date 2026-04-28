import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/widgets/inventory_content.dart';
import 'package:inventory_app/inventory/widgets/inventory_drawer.dart';
import 'package:inventory_app/inventory/widgets/inventory_nav_rail.dart';
import 'package:inventory_app/inventory/widgets/inventory_storages_panel.dart';
import 'package:inventory_app/inventory/widgets/inventory_tags_panel.dart';
import 'package:inventory_app/inventory/widgets/inventory_tool_bar.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/settings/settings.dart';
import 'package:inventory_app/shared/constants/layout.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages_editor/view/storages_editor_page.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/widgets/tags_bottom_sheet.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

/// The root page for the inventory feature.
///
/// Provides [InventoryBloc] and lazily provides [StoragesBloc],
/// [TagsBloc], and [StatisticsBloc] so that the expanded web layout can
/// embed section panels without Navigator pushes.
class InventoryPage extends StatelessWidget {
  /// Creates an [InventoryPage].
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InventoryBloc(
            watchPartPresentations: context.read<WatchPartPresentations>(),
          ),
        ),
        BlocProvider(
          create: (context) => StoragesBloc(
            storageRepository: context.read<StorageRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              TagsBloc(tagRepository: context.read<TagRepository>()),
        ),
        BlocProvider(
          create: (context) => StatisticsBloc(
            stockRepository: context.read<StockRepository>(),
          ),
        ),
      ],
      child: const InventoryView(),
    );
  }
}

/// The main inventory screen.
///
/// On narrow viewports (< [kExpandedBreakpoint]) the layout uses a swipe-open
/// [Drawer] with standard [Navigator] pushes. On wide viewports a permanent
/// [NavigationRail] is shown and section content is swapped in-place without
/// any route push, giving a tab-view feel.
class InventoryView extends StatefulWidget {
  /// Creates an [InventoryView].
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView>
    with TickerProviderStateMixin {
  /// Currently selected rail destination.
  ///
  /// - 0: Inventory (parts list)
  /// - 1: Storages
  /// - 2: Tags
  /// - 3: Statistics
  /// - 4: Settings
  int _selectedIndex = 0;

  /// Tab controller shared between the Tags panel and the AppBar [TabBar].
  late final TabController _tagsTabController;

  @override
  void initState() {
    super.initState();
    _tagsTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tagsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userName = context.watch<UserCubit>().state.maybeWhen(
      loaded: (currentUser) => currentUser.name,
      orElse: () => '',
    );
    final isExpanded =
        MediaQuery.sizeOf(context).width >= kExpandedBreakpoint;

    return Scaffold(
      resizeToAvoidBottomInset: !kIsWeb,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isExpanded && _selectedIndex != 0 ? _sectionTitle(l10n) : userName,
        ),
        // Show the Tags TabBar in the AppBar only when the Tags panel is
        // active in expanded mode.
        bottom: isExpanded && _selectedIndex == 2
            ? TabBar(
                controller: _tagsTabController,
                tabs: [
                  Tab(child: Text(l10n.tagTabBrandText)),
                  Tab(child: Text(l10n.tagTabCategoryText)),
                  Tab(child: Text(l10n.tagTabGeneralText)),
                ],
              )
            : null,
      ),
      drawer: isExpanded ? null : const InventoryDrawer(),
      floatingActionButton: isExpanded
          ? _expandedFab(context, l10n)
          : const InventoryToolBar(),
      floatingActionButtonLocation: .miniCenterFloat,
      body: SafeArea(
        top: false,
        child: isExpanded
            ? Row(
                children: [
                  InventoryNavRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) =>
                        setState(() => _selectedIndex = index),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: kContentMaxWidth,
                        ),
                        child: _expandedContent(),
                      ),
                    ),
                  ),
                ],
              )
            : const InventoryContent(),
      ),
    );
  }

  /// Returns the AppBar title string for the currently selected section.
  String _sectionTitle(AppLocalizations l10n) => switch (_selectedIndex) {
    1 => l10n.storagePageTitle,
    2 => l10n.tagPageTitleText,
    3 => l10n.drawerStatisticsLinkText,
    4 => l10n.settingsPageTitle,
    _ => '',
  };

  /// Returns the appropriate FAB for the active section in expanded layout.
  Widget? _expandedFab(BuildContext context, AppLocalizations l10n) {
    return switch (_selectedIndex) {
      0 => const InventoryToolBar(),
      1 => FloatingActionButton.extended(
          label: Text(l10n.addStorageFabLabelText),
          icon: const Icon(Icons.add),
          onPressed: () =>
              unawaited(Navigator.push(context, StoragesEditorPage.route())),
        ),
      2 => FloatingActionButton.extended(
          label: Text(l10n.tagPageFabText),
          icon: const Icon(Icons.add),
          onPressed: () => unawaited(
            showModalBottomSheet<void>(
              isScrollControlled: true,
              showDragHandle: true,
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<TagsBloc>(),
                child: SafeArea(
                  child: TagsBottomSheet.create(
                    initialBrand: TagType.values[_tagsTabController.index],
                  ),
                ),
              ),
            ),
          ),
        ),
      _ => null,
    };
  }

  /// Returns the body widget for the currently selected section.
  Widget _expandedContent() => switch (_selectedIndex) {
    0 => const InventoryContent(),
    1 => const InventoryStoragesPanel(),
    2 => InventoryTagsPanel(tabController: _tagsTabController),
    3 => const StatisticsView(),
    4 => const SettingsView(),
    _ => const InventoryContent(),
  };
}
