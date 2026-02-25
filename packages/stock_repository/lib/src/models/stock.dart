import 'package:stock_remote_data_source/stock_remote_data_source.dart';

class Stock {
  Stock({
    required this.storageId,
    required this.partId,
    required this.quantity,
  });

  factory Stock.fromDto(StockDto dto) => Stock(
    storageId: dto.storageId,
    partId: dto.partId,
    quantity: dto.quantity,
  );

  final String storageId;
  final String partId;
  final int quantity;
}
