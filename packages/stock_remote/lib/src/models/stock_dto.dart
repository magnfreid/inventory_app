import 'package:json_annotation/json_annotation.dart';

part 'stock_dto.g.dart';

@JsonSerializable()
class StockDto {
  StockDto({
    required this.partId,
    required this.storageId,
    required this.quantity,
  });

  factory StockDto.fromJson(Map<String, dynamic> json) =>
      _$StockDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StockDtoToJson(this);

  final String partId;
  final String storageId;
  final int quantity;
}
