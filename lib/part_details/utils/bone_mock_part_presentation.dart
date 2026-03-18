import 'package:flutter/material.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:skeletonizer/skeletonizer.dart';

final boneMockPartPresentation = PartPresentation(
  partId: BoneMock.subtitle,
  name: BoneMock.subtitle,
  detailNumber: BoneMock.subtitle,
  price: 10,
  isRecycled: false,
  description: BoneMock.subtitle,
  brandTag: TagPresentation(
    id: '',
    label: BoneMock.title,
    color: Colors.blue,
    type: .brand,
  ),
  categoryTag: TagPresentation(
    id: '',
    label: BoneMock.title,
    color: Colors.red,
    type: .category,
  ),
);
