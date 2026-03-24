import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

class WatchPartPresentations {
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

  Stream<List<PartPresentation>> call() {
    return Rx.combineLatest4<
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
                final storage = storagesMap[stock.storageId];
                return StockPresentation(
                  partId: part.id!,
                  storageId: stock.storageId,
                  storageName: storage?.name ?? 'Unknown',
                  quantity: stock.quantity,
                );
              }).toList();

              final categoryTag = part.categoryTagId != null
                  ? tagsMap[part.categoryTagId!]
                  : null;
              final brandTag = part.brandTagId != null
                  ? tagsMap[part.brandTagId!]
                  : null;

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
                description: part.description,
                stock: storageQuantities,
              );
            }).toList();
          },
        )
        .shareReplay(maxSize: 1);
  }
}
