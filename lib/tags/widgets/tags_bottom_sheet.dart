import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/tag_repository.dart';

class TagsBottomSheet extends StatefulWidget {
  const TagsBottomSheet({super.key});

  @override
  State<TagsBottomSheet> createState() => _TagsBottomSheetState();
}

class _TagsBottomSheetState extends State<TagsBottomSheet> {
  late final TextEditingController _labelTextController;
  late final TagColor _selectedTagColor;

  @override
  void initState() {
    _labelTextController = TextEditingController();
    _selectedTagColor = .white;
    super.initState();
  }

  @override
  void dispose() {
    _labelTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TagsBloc, TagsState>(
      listenWhen: (previous, current) => current.bottomSheetStatus == .success,
      listener: (context, state) => Navigator.pop(context),
      child: Column(
        children: [
          TextFormField(
            controller: _labelTextController,
          ),
          AppButton(
            onPressed: () {
              if (_labelTextController.text.isEmpty) return;
              context.read<TagsBloc>().add(
                SaveButtonPressed(
                  tag: TagCreate(
                    label: _labelTextController.text,
                    color: _selectedTagColor,
                  ),
                ),
              );
            },
            label: 'Save',
          ),
        ],
      ),
    );
  }
}
