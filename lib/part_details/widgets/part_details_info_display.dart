import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/widgets/recycled_icon.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class PartDetailsInfoDisplay extends StatelessWidget {
  const PartDetailsInfoDisplay({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final description = part.description;
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Column(
        children: [
          _DetailField(
            title: l10n.formFieldDetailNumberLabelText,
            trailing: part.detailNumber.isEmpty ? '-' : part.detailNumber,
          ),
          _DetailField(
            title: l10n.formFieldRecycledStatusLabelText,
            trailing: part.isRecycled
                ? l10n.formFieldRecycledLabelText
                : l10n.formFieldNewLabelText,
            icon: part.isRecycled ? const RecycledIcon() : null,
          ),
          _DetailField(
            title: l10n.formFieldPriceLabelText,
            trailing: NumberFormat.currency(
              locale: 'sv_SE',
              symbol: 'kr',
              decimalDigits: 2,
            ).format(part.price),
          ),
          if (description != null && description.isNotEmpty)
            Padding(
              padding: const .symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    context.l10n.formFieldDescriptionLabelText,
                  ),
                  const SizedBox(
                    height: 4,
                    width: double.infinity,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.title, required this.trailing, this.icon});

  final String title;
  final String trailing;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title),
          Row(
            spacing: 4,
            children: [
              ?icon,
              Text(
                trailing,
                style: TextStyle(color: context.colors.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
