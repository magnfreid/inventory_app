import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_remote/stock_remote.dart';
import 'package:stock_repository/stock_repository.dart';

class MockStockRemote extends Mock implements StockRemote {}

void main() {
  late MockStockRemote mockRemote;
  late StockRepository repository;
  late StockDto dto;

  setUpAll(() {
    registerFallbackValue(
      StockDto(partId: 'fallback', storageId: 'fallback', quantity: 0),
    );
  });

  setUp(() {
    mockRemote = MockStockRemote();
    repository = StockRepository(remote: mockRemote);

    dto = StockDto(partId: 'p1', storageId: 's1', quantity: 10);
  });

  test('watchStock maps DTOs to domain models', () async {
    when(() => mockRemote.watchStock()).thenAnswer((_) => Stream.value([dto]));

    final stocks = await repository.watchStock().first;

    expect(stocks.first.partId, dto.partId);
    expect(stocks.first.storageId, dto.storageId);
    expect(stocks.first.quantity, dto.quantity);
  });

  test('increaseStock calls remote with correct parameters', () async {
    when(
      () => mockRemote.increaseStock(any(), any(), any()),
    ).thenAnswer((_) async {});

    await repository.increaseStock(partId: 'p1', storageId: 's1', amount: 5);

    verify(() => mockRemote.increaseStock('p1', 's1', 5)).called(1);
  });

  test('decreaseStock calls remote with correct parameters', () async {
    when(
      () => mockRemote.decreaseStock(any(), any(), any()),
    ).thenAnswer((_) async {});

    await repository.decreaseStock(partId: 'p1', storageId: 's1', amount: 3);

    verify(() => mockRemote.decreaseStock('p1', 's1', 3)).called(1);
  });
}
