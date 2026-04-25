import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:core_remote/core_remote.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_drawer.dart';
import 'package:inventory_app/inventory/widgets/inventory_part_card.dart';
import 'package:inventory_app/inventory/widgets/inventory_tool_bar.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/settings/settings.dart';
import 'package:inventory_app/shared/constants/layout.dart';
import 'package:inventory_app/shared/extensions/list_sorting_extension.dart';
import 'package:inventory_app/shared/extensions/part_filtering_extension.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/shared/utilities/bone_mocks.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_app/storages_editor/view/storages_editor_page.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:inventory_app/tags/view/tags_page.dart';
import 'package:inventory_app/tags/widgets/tags_bottom_sheet.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
            tagRepository: context.read<TagRepository>(),
            storageRepository: context.read<StorageRepository>(),
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
                  _InventoryNavRail(
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
            : const _InventoryContent(),
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
    0 => const _InventoryContent(),
    1 => const _StoragesPanel(),
    2 => _TagsPanel(tabController: _tagsTabController),
    3 => const StatisticsView(),
    4 => const SettingsView(),
    _ => const _InventoryContent(),
  };
}

/// Permanent navigation rail shown on wide-screen layouts.
///
/// Highlights the [selectedIndex] destination and fires
/// [onDestinationSelected] when the user taps a rail item. Destinations
/// mirror the [InventoryDrawer] items.
class _InventoryNavRail extends StatelessWidget {
  const _InventoryNavRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
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

/// Embedded storages panel for the expanded web layout.
///
/// Renders the storages list without a [Scaffold], using the [StoragesBloc]
/// provided by the ancestor [InventoryPage].
class _StoragesPanel extends StatelessWidget {
  const _StoragesPanel();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<StoragesBloc, StoragesState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final error = state.error;
        if (error != null) context.showErrorSnackBar(error);
      },
      child: BlocBuilder<StoragesBloc, StoragesState>(
        builder: (context, state) {
          return switch (state.status) {
            .loading => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            .loaded => state.storages.isEmpty
                ? Center(child: Text(l10n.storage))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ExpansionPanelList.radio(
                        expandedHeaderPadding: const .only(left: 8),
                        elevation: 1,
                        dividerColor: Colors.transparent,
                        children: state.storages
                            .sortedByName()
                            .map(
                              (storage) => ExpansionPanelRadio(
                                canTapOnHeader: true,
                                value: storage.id ?? 0,
                                headerBuilder: (context, isExpanded) => Text(
                                  storage.name,
                                  style: isExpanded
                                      ? context.text.bodyLarge?.copyWith(
                                          color: Colors.blue,
                                        )
                                      : null,
                                ),
                                body: StoragePanelBody(storage: storage),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
          };
        },
      ),
    );
  }
}

/// Embedded tags panel for the expanded web layout.
///
/// Renders a [TabBarView] using the provided [tabController], using the
/// [TagsBloc] provided by the ancestor [InventoryPage].
class _TagsPanel extends StatelessWidget {
  const _TagsPanel({required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TagsBloc, TagsState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final error = state.error;
        if (error != null) context.showErrorSnackBar(error);
      },
      child: BlocBuilder<TagsBloc, TagsState>(
        builder: (context, state) {
          return TabBarView(
            controller: tabController,
            children: [
              TagTabContent(tags: state.brandTags),
              TagTabContent(tags: state.categoryTags),
              TagTabContent(tags: state.generalTags),
            ],
          );
        },
      ),
    );
  }
}

/// The scrollable parts list and filter controls.
///
/// Shared between compact and expanded layouts — width constraints are applied
/// by the parent, not here.
class _InventoryContent extends StatelessWidget {
  const _InventoryContent();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<InventoryBloc, InventoryState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final error = state.error;
        if (error != null) context.showErrorSnackBar(error);
      },
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final error = state.error;
          final parts =
              state.isLoading ? boneMockParts : state.filteredParts;
          return Padding(
            padding: const .symmetric(horizontal: 8),
            child: Column(
              children: [
                if (error != null && error is NetworkException)
                  Row(
                    children: [
                      const Padding(
                        padding: .symmetric(horizontal: 8, vertical: 4),
                        child: Icon(Icons.warning, color: Colors.yellow),
                      ),
                      Text(error.toL10n(context)),
                    ],
                  ),
                Padding(
                  padding: const .symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Text('${l10n.showing}:'),
                          Text(state.filteredParts.length.toString()),
                          Text(
                            '(${l10n.ofText} ${state.parts.length})',
                            style: TextStyle(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(l10n.inventoryShowEmptyStockText),
                          ScaleTransition(
                            scale: const AlwaysStoppedAnimation(0.6),
                            child: Switch(
                              value:
                                  state.filter.quantityFilter == .inStock,
                              onChanged: (_) =>
                                  context.read<InventoryBloc>().add(
                                    const HideEmptyStockSwitchPressed(),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Skeletonizer(
                    enabled: state.isLoading,
                    child: parts.isEmpty
                        ? Center(child: Text(l10n.partsListEmpty))
                        : ListView.builder(
                            padding: const .only(bottom: 140),
                            itemCount: parts.length,
                            itemBuilder: (context, index) =>
                                InventoryPartCard(part: parts[index]),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
