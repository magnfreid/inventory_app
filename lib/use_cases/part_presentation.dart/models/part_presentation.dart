import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:part_repository/part_repository.dart';

part 'part_presentation.freezed.dart';

@freezed
abstract class PartPresentation with _$PartPresentation {
  const factory PartPresentation({
    required String partId,
    required String name,
    required String detailNumber,
    required double price,
    required bool isRecycled,
    @Default([]) List<StockPresentation> stock,
    TagPresentation? categoryTag,
    TagPresentation? brandTag,
    @Default([]) List<TagPresentation> generalTags,
    String? description,
    String? imgPath,
    String? thumbnailPath,
  }) = _Part;

  const PartPresentation._();

  Part toDomainModel() => Part(
    id: partId,
    name: name,
    detailNumber: detailNumber,
    price: price,
    isRecycled: isRecycled,
    brandTagId: brandTag?.id,
    categoryTagId: categoryTag?.id,
    generalTagIds: generalTags.map((tag) => tag.id).toList(),
    description: description,
    imgPath: imgPath,
    thumbnailPath: thumbnailPath,
  );

  int get totalQuantity =>
      stock.fold(0, (sum, element) => sum + element.quantity);
}
