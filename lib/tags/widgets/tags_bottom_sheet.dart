import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:inventory_app/tags/extensions/tag_color_extension.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:tag_repository/tag_repository.dart';

class TagsBottomSheet extends StatefulWidget {
  const TagsBottomSheet.create({TagType initialBrand = .brand, super.key})
    : _initialBrand = initialBrand,
      _tag = null;
  TagsBottomSheet.edit({required TagPresentation tag, super.key})
    : _tag = tag,
      _initialBrand = tag.type;

  final TagType _initialBrand;
  final TagPresentation? _tag;

  @override
  State<TagsBottomSheet> createState() => _TagsBottomSheetState();
}

class _TagsBottomSheetState extends State<TagsBottomSheet> {
  late final TextEditingController _labelTextController;
  late Color _selectedColor;
  late TagType _selectedTagType;

  @override
  void initState() {
    _selectedTagType = widget._initialBrand;
    _labelTextController = TextEditingController(text: widget._tag?.label);
    _selectedColor = widget._tag?.color ?? TagColor.values.first.toColor();
    super.initState();
  }

  @override
  void dispose() {
    _labelTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<TagsBloc, TagsState>(
      listenWhen: (previous, current) => current.bottomSheetStatus == .done,
      listener: (context, state) => Navigator.pop(context),
      child: Padding(
        padding: const .fromLTRB(16, 8, 16, 24),
        child: FractionallySizedBox(
          heightFactor: 0.7,
          child: Column(
            mainAxisSize: .min,
            spacing: 20,
            children: [
              Align(
                alignment: .centerStart,
                child: Text(
                  widget._tag?.id == null
                      ? l10n.tagsBottomSheetCreateTitleText
                      : l10n.tagsBottomSheetEditTitleText,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Divider(),
              TextFormField(
                textCapitalization: .sentences,
                controller: _labelTextController,
                decoration: InputDecoration(
                  label: Text(l10n.formFieldNameLabelText),
                ),
              ),

              SegmentedButton<TagType>(
                segments: [
                  ButtonSegment(
                    label: Text(l10n.tagsBottomSheetBrandText),
                    icon: const Icon(Icons.business),
                    value: .brand,
                  ),
                  ButtonSegment(
                    value: .category,
                    icon: const Icon(Icons.category),
                    label: Text(l10n.tagsBottomSheetCategoryText),
                  ),
                  ButtonSegment(
                    value: .general,
                    icon: const Icon(Icons.sell),
                    label: Text(l10n.tagsBottomSheetGeneralText),
                  ),
                ],
                selected: {_selectedTagType},
                onSelectionChanged: (selection) =>
                    setState(() => _selectedTagType = selection.first),
              ),

              _ColorSelector(
                colors: TagColor.values
                    .map((tagColor) => tagColor.toColor())
                    .toList(),
                initialColor:
                    widget._tag?.color ?? TagColor.values.first.toColor(),
                onTap: (color) => _selectedColor = color,
              ),
              const Divider(),
              const Spacer(),
              AppButton(
                onPressed: () {
                  if (_labelTextController.text.isEmpty) return;
                  context.read<TagsBloc>().add(
                    SaveButtonPressed(
                      tag: Tag(
                        label: _labelTextController.text,
                        color: TagColorX.fromColor(_selectedColor),
                        type: _selectedTagType,
                        id: widget._tag?.id,
                      ),
                    ),
                  );
                },
                label: l10n.saveButtonText,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorSelector extends StatefulWidget {
  const _ColorSelector({
    required this.colors,
    required this.onTap,
    this.initialColor,
  });

  final List<Color> colors;
  final Color? initialColor;
  final void Function(Color selectedColor) onTap;

  @override
  State<_ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<_ColorSelector> {
  late Color selectedColor;

  @override
  void initState() {
    selectedColor = widget.initialColor ?? widget.colors.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.colors
          .map(
            (color) => Padding(
              padding: const .all(2),
              child: GestureDetector(
                onTap: () => setState(() {
                  widget.onTap(color);
                  selectedColor = color;
                }),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: color == selectedColor
                        ? Border.all(
                            color: context.colors.onPrimaryContainer,
                            width: 4,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
