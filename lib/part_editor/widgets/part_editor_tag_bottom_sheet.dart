import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';

enum TagBottomSheetMode { brand, category }

class PartEditorSingleTagBottomSheet extends StatelessWidget {
  const PartEditorSingleTagBottomSheet({
    required this.mode,
    super.key,
  });

  final TagBottomSheetMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartEditorBloc, PartEditorState>(
      buildWhen: (previous, current) => switch (mode) {
        .brand => previous.brandTags != current.brandTags,
        .category => previous.categoryTags != current.categoryTags,
      },
      builder: (context, state) {
        final tags = switch (mode) {
          .brand => state.brandTags,
          .category => state.categoryTags,
        };
        return Column(
          children: [
            const Text('Title'),
            if (tags.isEmpty)
              const Center(child: Text('No tags added yet!'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    return ListTile(
                      onTap: () => Navigator.pop(context, tag),
                      title: Text(tag.label),
                      trailing: Icon(Icons.business, color: tag.color),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
