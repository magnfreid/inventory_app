import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class PartDetailsInfo extends StatelessWidget {
  const PartDetailsInfo(this.part, {super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final description = part.description;

    return Column(
      children: [
        // _MainTagsRow(part: part),
        _DetailField(
          title: l10n.formFieldDetailNumberLabelText,
          subtitle: part.detailNumber,
        ),
        _DetailField(
          title: l10n.formFieldPriceLabelText,
          subtitle: NumberFormat.currency(
            locale: 'sv_SE',
            symbol: 'kr',
            decimalDigits: 2,
          ).format(part.price),
        ),
        _DetailField(
          title: l10n.formFieldRecycledStatusLabelText,
          subtitle: part.isRecycled
              ? l10n.formFieldRecycledLabelText
              : l10n.formFieldNewLabelText,
        ),
        _DetailField(
          title: l10n.formFieldBrandLabelText,
          subtitle: part.brandTag?.label ?? '-',
        ),
        _DetailField(
          title: l10n.formFieldCategoryLabelText,
          subtitle: part.categoryTag?.label ?? '_',
        ),
        _DetailField(
          title: l10n.formFieldInStockLabelText,
          subtitle: part.totalQuantity.toString(),
        ),
        if (description != null && description.isNotEmpty)
          Padding(
            padding: const .symmetric(vertical: 16),
            child: Column(
              spacing: 8,
              crossAxisAlignment: .start,
              children: [
                Text(
                  l10n.formFieldDescriptionLabelText,
                  style: context.text.bodyLarge,
                ),
                Text(
                  description,
                  style: context.text.bodyLarge?.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.text.bodyLarge;
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  style: textStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .end,
              children: [
                Text(
                  subtitle,
                  style: textStyle?.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _MainTagsRow extends StatelessWidget {
//   const _MainTagsRow({required this.part});

//   final PartPresentation part;

//   @override
//   Widget build(BuildContext context) {
//     final brandTag = part.brandTag;
//     final categoryTag = part.categoryTag;
//     return Padding(
//       padding: const .all(4),
//       child: Row(
//         spacing: 12,
//         children: [
//           if (brandTag != null)
//             TagBadge(
//               tag: brandTag,
//               fontSize: 16,
//             ),

//           if (categoryTag != null)
//             TagBadge(
//               tag: categoryTag,
//               fontSize: 16,
//             ),
//         ],
//       ),
//     );
//   }
// }
