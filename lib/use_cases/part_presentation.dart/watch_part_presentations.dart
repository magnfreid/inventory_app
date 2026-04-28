import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

/// Combines the four live repository streams (parts, stock, storages, tags)
/// into a single stream of fully resolved [PartPresentation] objects.
///
/// The resulting stream is **multicast with replay**: all callers share one
/// set of Firestore subscriptions regardless of how many times [call] is
/// invoked. The last emitted value is replayed to late subscribers.
class WatchPartPresentations {
  /// Creates a [WatchPartPresentations] use case.
  WatchPartPresentations({
    required PartRepository partRepository,
    required StorageRepository storageRepository,
    required StockRepository stockRepository,
    required TagRepository tagRepository,
  }) : _partRepository = partRepository,
       _storageRepository = storageRepository,
       _stockRepository = stockRepository,
       _tagRepository = tagRepository;

  final PartRepository _partRepository;
  final StorageRepository _storageRepository;
  final StockRepository _stockRepository;
  final TagRepository _tagRepository;

  // Lazily initialised on first call and reused thereafter, so that
  // shareReplay actually multicasts across all callers.
  late final Stream<List<PartPresentation>> _stream = Rx.combineLatest4<
        List<Stock>,
        List<Part>,
        List<Storage>,
        List<Tag>,
        List<PartPresentation>
      >(
        _stockRepository.watchStock(),
        _partRepository.watchParts(),
        _storageRepository.watchStorages(),
        _tagRepository.watchTags(),
        (stocks, parts, storages, tags) {
          final storagesMap = {for (final s in storages) s.id: s};
          final tagsMap = {for (final t in tags) t.id: t};

          final stockByPart = <String, List<Stock>>{};
          for (final stock in stocks) {
            stockByPart.putIfAbsent(stock.partId, () => []).add(stock);
          }

          return parts.map((part) {
            final partStock = stockByPart[part.id] ?? const [];
            final storageQuantities = partStock.map((stock) {
              final storageName =
                  storagesMap[stock.storageId]?.name ?? stock.storageId;
              return StockPresentation(
                partId: part.id!,
                storageId: stock.storageId,
                storageName: storageName,
                quantity: stock.quantity,
              );
            }).toList();

            final categoryTag = part.categoryTagId != null
                ? tagsMap[part.categoryTagId!]
                : null;
            final brandTag = part.brandTagId != null
                ? tagsMap[part.brandTagId!]
                : null;
            final generalTags = part.generalTagIds
                .map((id) => tagsMap[id])
                .whereType<Tag>()
                .map(TagPresentation.fromDomainModel)
                .toList();

            return PartPresentation(
              partId: part.id ?? '',
              name: part.name,
              detailNumber: part.detailNumber,
              price: part.price,
              isRecycled: part.isRecycled,
              brandTag: brandTag == null
                  ? null
                  : TagPresentation.fromDomainModel(brandTag),
              categoryTag: categoryTag == null
                  ? null
                  : TagPresentation.fromDomainModel(categoryTag),
              generalTags: generalTags,
              description: part.description,
              stock: storageQuantities,
              imgPath: part.imgPath,
              thumbnailPath: part.thumbnailPath,
            );
          }).toList();
        },
      )
      .shareReplay(maxSize: 1);

  /// Returns the shared, replaying stream of all [PartPresentation] objects.
  ///
  /// Safe to call multiple times — all callers receive the same stream
  /// instance and share the underlying Firestore subscriptions.
  Stream<List<PartPresentation>> call() => _stream;
}
