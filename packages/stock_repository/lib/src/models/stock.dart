import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock {
  Stock({
    required this.storageId,
    required this.partId,
    required this.quantity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);

  final String storageId;
  final String partId;
  final int quantity;
}
