import 'package:flutter/material.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/l10n/l10n.dart';

class PartDetailsInfo extends StatelessWidget {
  const PartDetailsInfo(this.part, {super.key});

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        if (part.categoryTag != null)
          ListTile(
            title: Text(l10n.formFieldDetailNumberLabelText),
            trailing: Text(part.detailNumber),
          ),
        ListTile(
          title: Text(l10n.formFieldPriceLabelText),
          trailing: Text(part.price.toString()),
        ),
      ],
    );
  }
}
