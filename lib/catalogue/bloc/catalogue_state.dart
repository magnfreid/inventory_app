import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalogue_state.freezed.dart';

enum CatalogueStateStatus { loading, loaded }

@freezed
abstract class CatalogueState with _$CatalogueState {
  const factory CatalogueState({
    @Default(CatalogueStateStatus.loading) CatalogueStateStatus status,
    @Default([]) List<CatalogueItem> items,
  }) = _CatalogueState;
  const CatalogueState._();

  bool get isLoading => status == .loading;
}
