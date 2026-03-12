import 'package:flutter/material.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/l10n/l10n.dart';

extension SortByTypeX on SortByType {
  String toL10n(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      .name => l10n.name,
      .brand => l10n.brand,
      .category => l10n.category,
      .quantity => l10n.quantity,
    };
  }
}
