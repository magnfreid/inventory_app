import 'package:stock_remote/stock_remote.dart';

/// Domain model representing stock of a part at a specific storage location.
class Stock {
  /// Creates a [Stock] instance.
  Stock({
    required this.storageId,
    required this.partId,
    required this.quantity,
  });

  /// Creates a [Stock] from a [StockDto].
  factory Stock.fromDto(StockDto dto) => Stock(
    storageId: dto.storageId,
    partId: dto.partId,
    quantity: dto.quantity,
  );

  /// The ID of the storage location.
  final String storageId;

  /// The ID of the part associated with this stock entry.
  final String partId;

  /// Quantity of the part available at this storage location.
  final int quantity;
}
