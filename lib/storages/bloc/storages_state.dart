import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'storages_state.freezed.dart';

enum StoragesStateStatus { loading, loaded }

@freezed
abstract class StoragesState with _$StoragesState {
  const factory StoragesState({
    @Default(StoragesStateStatus.loading) StoragesStateStatus status,
    @Default([]) List<Storage> storages,
    Exception? error,
  }) = _StoragesState;
  const StoragesState._();
}
