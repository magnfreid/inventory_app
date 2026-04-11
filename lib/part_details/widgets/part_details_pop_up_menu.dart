import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/widgets/sheets/delete_image_sheet.dart';
import 'package:inventory_app/part_details/widgets/sheets/delete_part_sheet.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:share_plus/share_plus.dart';

enum _MenuAction { edit, share, deletePart, deleteImage }

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
        .share => Share.share(
          _sharePartAsText(
            context.read<PartDetailsBloc>().state.part,
            context.l10n,
          ),
          subject: context.read<PartDetailsBloc>().state.part.name,
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
            value: _MenuAction.share,
            child: Row(
              children: [
                const Icon(Icons.share),
                const SizedBox(width: 16),
                Text(l10n.popUpMenuShare),
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

/// Formats [part] as a plain-text string suitable for sharing.
///
/// Uses [l10n] for all user-visible labels so the output respects the
/// current app locale.
String _sharePartAsText(PartPresentation part, AppLocalizations l10n) {
  // Header — name and optional detail number on one line.
  final buffer = StringBuffer()
    ..write(part.name)
    ..write(
      part.detailNumber.isNotEmpty ? ' — ${part.detailNumber}' : '',
    )
    ..writeln();

  // Optional description.
  final description = part.description;
  if (description != null && description.isNotEmpty) {
    buffer.writeln(description);
  }

  // Price and recycled status.
  buffer
    ..writeln()
    ..writeln('${l10n.formFieldPriceLabelText}: ${part.price}')
    ..writeln(
      part.isRecycled ? l10n.shareTextRecycledYes : l10n.shareTextRecycledNo,
    );

  // Stock per storage (only non-zero entries).
  final stockInStorage = part.stock.where((s) => s.quantity > 0).toList();
  if (stockInStorage.isNotEmpty) {
    buffer
      ..writeln()
      ..writeln('${l10n.shareTextStock}:');
    for (final s in stockInStorage) {
      buffer.writeln(
        '  ${s.storageName}: ${s.quantity} ${l10n.pieces(s.quantity)}',
      );
    }
    buffer.write(
      '${l10n.inStockTotalText}: '
      '${part.totalQuantity} ${l10n.pieces(part.totalQuantity)}',
    );
  }

  return buffer.toString();
}
