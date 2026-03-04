import 'package:flutter/material.dart';
import 'package:inventory_app/tags/extensions/tag_color_extension.dart';
import 'package:tag_repository/tag_repository.dart';

class TagPresentation {
  TagPresentation({
    required this.id,
    required this.label,
    required this.color,
    required this.type,
  });

  factory TagPresentation.fromDomainModel(Tag domainModel) => TagPresentation(
    id: domainModel.id,
    label: domainModel.label,
    color: domainModel.color.toColor(),
    type: domainModel.type,
  );

  final String id;
  final String label;
  final Color color;
  final TagType type;
}
