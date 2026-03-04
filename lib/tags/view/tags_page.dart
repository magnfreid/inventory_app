import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/tags/widgets/tags_bottom_sheet.dart';
import 'package:tag_repository/tag_repository.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  static MaterialPageRoute<TagsPage> route() =>
      MaterialPageRoute(builder: (context) => const TagsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TagsBloc(tagRepository: context.read<TagRepository>()),
      child: const TagsView(),
    );
  }
}

class TagsView extends StatefulWidget {
  const TagsView({super.key});

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tagPageTitleText),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text(l10n.tagTabBrandText)),
            Tab(child: Text(l10n.tagTabCategoryText)),
            Tab(child: Text(l10n.tagTabGeneralText)),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet<void>(
          isScrollControlled: true,
          showDragHandle: true,
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<TagsBloc>(),
            child: SafeArea(
              child: TagsBottomSheet(
                initialBrand: TagType.values[_tabController.index],
              ),
            ),
          ),
        ),
        label: Text(l10n.tagPageFabText),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<TagsBloc, TagsState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              _TabContent(tags: state.brandTags),
              _TabContent(tags: state.categoryTags),
              _TabContent(tags: state.generalTags),
            ],
          );
        },
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.tags});

  final List<TagPresentation> tags;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return tags.isEmpty
        ? Center(child: Text(l10n.tagPageEmptyListText))
        : ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final tag = tags[index];
              return ListTile(
                title: Text(tag.label),
                iconColor: tag.color,
                trailing: const Icon(Icons.label),
              );
            },
          );
  }
}
