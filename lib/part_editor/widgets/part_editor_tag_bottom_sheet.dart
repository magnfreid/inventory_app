import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/shared/extensions/list_sorting_extension.dart';

enum TagBottomSheetMode { brand, category }

class PartEditorSingleTagBottomSheet extends StatelessWidget {
  const PartEditorSingleTagBottomSheet({
    required this.mode,
    super.key,
  });

  final TagBottomSheetMode mode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const .fromLTRB(24, 0, 24, 16),
        child: BlocBuilder<PartEditorBloc, PartEditorState>(
          buildWhen: (previous, current) => switch (mode) {
            .brand => previous.brandTags != current.brandTags,
            .category => previous.categoryTags != current.categoryTags,
          },
          builder: (context, state) {
            final tags = switch (mode) {
              .brand => state.brandTags.sortedByLabel(),
              .category => state.categoryTags.sortedByLabel(),
            };
            final title = switch (mode) {
              .brand => '${l10n.chooseBrand}:',
              .category => '${l10n.chooseCategory}:',
            };
            return Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: 20,
              children: [
                const SizedBox(width: double.infinity),
                Text(
                  title,
                  style: context.text.bodyLarge?.copyWith(fontWeight: .bold),
                ),
                if (tags.isEmpty)
                  Center(child: Text(l10n.tagPageEmptyListText))
                else
                  Wrap(
                    spacing: 10,
                    children: tags
                        .map(
                          (tag) => ActionChip(
                            avatar: Icon(Icons.tag, color: tag.color),
                            label: Text(tag.label),
                            onPressed: () => Navigator.pop(context, tag),
                          ),
                        )
                        .toList(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
