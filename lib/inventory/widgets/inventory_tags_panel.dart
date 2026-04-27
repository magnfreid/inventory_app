import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:inventory_app/tags/view/tags_page.dart';

/// Embedded tags panel for the expanded web layout.
///
/// Renders a [TabBarView] using the provided [tabController], driven by the
/// [TagsBloc] provided by the ancestor inventory page.
class InventoryTagsPanel extends StatelessWidget {
  /// Creates an [InventoryTagsPanel].
  const InventoryTagsPanel({required this.tabController, super.key});

  /// Controls which tag type tab is shown.
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
