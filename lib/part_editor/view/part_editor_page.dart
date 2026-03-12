import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/part_editor/widgets/part_editor_tag_bottom_sheet.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:tag_repository/tag_repository.dart';

class PartEditorPage extends StatelessWidget {
  const PartEditorPage({this.part, super.key});

  static MaterialPageRoute<void> route({PartPresentation? part}) =>
      MaterialPageRoute<void>(
        builder: (context) => PartEditorPage(
          part: part,
        ),
      );

  final PartPresentation? part;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartEditorBloc(
        partRepository: context.read<PartRepository>(),
        tagRepository: context.read<TagRepository>(),
      ),
      child: PartEditorView(part: part),
    );
  }
}

class PartEditorView extends StatefulWidget {
  const PartEditorView({this.part, super.key});

  final PartPresentation? part;

  @override
  State<PartEditorView> createState() => _PartEditorViewState();
}

class _PartEditorViewState extends State<PartEditorView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _detailNumberController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  late TagPresentation? _selectedBrandTag;
  late TagPresentation? _selectedCategoryTag;
  List<TagPresentation> selectedGeneralTags = [];

  late bool _isRecycled;
  late bool _canSave;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.part?.name ?? '');
    _detailNumberController = TextEditingController(
      text: widget.part?.detailNumber ?? '',
    );
    _priceController = TextEditingController(
      text: widget.part?.price.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.part?.description ?? '',
    );
    _isRecycled = widget.part?.isRecycled ?? true;
    _canSave = widget.part != null;
    _selectedBrandTag = widget.part?.brandTag;
    _selectedCategoryTag = widget.part?.categoryTag;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailNumberController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<PartEditorBloc, PartEditorState>(
      listenWhen: (previous, current) => current.isSuccess,
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.part?.name ?? l10n.formFieldTitleText),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const .all(24),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      Form(
                        key: _formKey,
                        onChanged: () => setState(
                          () => _canSave =
                              _formKey.currentState?.validate() ?? false,
                        ),
                        child: Column(
                          spacing: 10,
                          mainAxisSize: .min,
                          children: [
                            TextFormField(
                              textCapitalization: .sentences,
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: '${l10n.formFieldNameLabelText}*',
                              ),
                              autovalidateMode: .onUserInteraction,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? l10n.validationRequired
                                  : null,
                            ),
                            TextFormField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                labelText: '${l10n.formFieldPriceLabelText}*',
                              ),
                              autovalidateMode: .onUserInteraction,
                              keyboardType: const .numberWithOptions(
                                decimal: true,
                              ),
                              onChanged: (value) {
                                final normalized = value.replaceAll(',', '.');
                                _priceController.value = TextEditingValue(
                                  text: normalized,
                                );
                              },
                              validator: (value) =>
                                  double.tryParse(value ?? '') == null
                                  ? l10n.validationEnterNumber
                                  : null,
                            ),
                            TextFormField(
                              textCapitalization: .sentences,
                              controller: _detailNumberController,
                              decoration: InputDecoration(
                                labelText: l10n.formFieldDetailNumberLabelText,
                              ),
                            ),
                            TextFormField(
                              textCapitalization: .sentences,
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                labelText: l10n.formFieldDescriptionLabelText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SegmentedButton<bool>(
                        segments: [
                          ButtonSegment<bool>(
                            value: false,
                            label: Text(l10n.formFieldNewLabelText),
                            icon: const Icon(Icons.inventory_outlined),
                          ),
                          ButtonSegment<bool>(
                            value: true,
                            label: Text(l10n.formFieldRecycledLabelText),
                            icon: const Icon(Icons.eco),
                          ),
                        ],
                        selected: {_isRecycled},
                        onSelectionChanged: (selection) =>
                            setState(() => _isRecycled = selection.first),
                      ),
                      _TagSelector(
                        tag: _selectedBrandTag,
                        mode: .brand,
                        onTagSelected: (selectedTag) =>
                            setState(() => _selectedBrandTag = selectedTag),
                      ),
                      _TagSelector(
                        tag: _selectedCategoryTag,
                        mode: .category,
                        onTagSelected: (selectedTag) =>
                            setState(() => _selectedCategoryTag = selectedTag),
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: .bottomCenter,

                child: BlocBuilder<PartEditorBloc, PartEditorState>(
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    return AppButton(
                      isLoading: state.isLoading,
                      onPressed: _canSave
                          ? () => context.read<PartEditorBloc>().add(
                              SaveButtonPressed(
                                part: Part(
                                  id: widget.part?.partId,
                                  name: _nameController.text,
                                  detailNumber: _detailNumberController.text,
                                  isRecycled: _isRecycled,
                                  price:
                                      double.tryParse(
                                        _priceController.text,
                                      ) ??
                                      0.0,
                                  brandTagId: _selectedBrandTag?.id,
                                  categoryTagId: _selectedCategoryTag?.id,
                                  generalTagIds: [],
                                  description: _descriptionController.text,
                                ),
                              ),
                            )
                          : null,
                      label: l10n.formSaveButtonText,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagSelector extends StatelessWidget {
  const _TagSelector({
    required this.mode,
    required this.onTagSelected,
    required this.tag,
  });

  final TagPresentation? tag;
  final TagBottomSheetMode mode;
  final void Function(TagPresentation? selectedTag) onTagSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = switch (mode) {
      .brand => l10n.brand,
      .category => l10n.category,
    };
    return ListTile(
      title: Text(title),
      trailing: tag == null
          ? TextButton(
              onPressed: () => _showSelectSingleTagBottomSheet(context),
              child: Text(l10n.select),
            )
          : InputChip(
              onDeleted: () => onTagSelected(null),
              label: Text(tag!.label),
              avatar: Icon(
                Icons.tag,
                color: tag!.color,
              ),
            ),
    );
  }

  Future<void> _showSelectSingleTagBottomSheet(BuildContext context) async {
    final selectedTag = await showModalBottomSheet<TagPresentation>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PartEditorBloc>(),
        child: PartEditorSingleTagBottomSheet(mode: mode),
      ),
    );
    if (selectedTag == null) return;
    onTagSelected(selectedTag);
  }
}
