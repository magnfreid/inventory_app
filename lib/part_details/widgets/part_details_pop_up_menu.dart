import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/widgets/sheets/delete_image_sheet.dart';
import 'package:inventory_app/part_details/widgets/sheets/delete_part_sheet.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';

enum _MenuAction { edit, deletePart, deleteImage }

class PartDetailsPopUpMenu extends StatelessWidget {
  const PartDetailsPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopupMenuButton<_MenuAction>(
      onSelected: (value) => switch (value) {
        .edit => Navigator.push(
          context,
          PartEditorPage.route(
            part: context.read<PartDetailsBloc>().state.part,
          ),
        ),
        .deletePart => showModalBottomSheet<void>(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<PartDetailsBloc>(),
            child: DeletePartSheet(
              partId: context.read<PartDetailsBloc>().state.part.partId,
            ),
          ),
        ),
        _MenuAction.deleteImage => showModalBottomSheet<void>(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<PartDetailsBloc>(),
            child: DeleteImageSheet(
              part: context.read<PartDetailsBloc>().state.part,
            ),
          ),
        ),
      },
      itemBuilder: (_) {
        return [
          PopupMenuItem(
            value: _MenuAction.edit,
            child: Row(
              children: [
                const Icon(Icons.edit),
                const SizedBox(width: 16),
                Text(l10n.edit),
              ],
            ),
          ),
          PopupMenuItem(
            value: _MenuAction.deleteImage,
            child: Row(
              children: [
                const Icon(Icons.image_not_supported),
                const SizedBox(width: 16),
                Text(l10n.popUpMenuDeleteImage),
              ],
            ),
          ),
          const PopupMenuDivider(),

          PopupMenuItem(
            value: _MenuAction.deletePart,
            child: Row(
              children: [
                Icon(Icons.delete, color: context.colors.error),
                const SizedBox(width: 16),
                Text(
                  l10n.delete,
                  style: TextStyle(color: context.colors.error),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
