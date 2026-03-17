part of 'storages_bloc.dart';

sealed class StoragesEvent {
  const StoragesEvent();
}

final class _StoragesUpdated extends StoragesEvent {
  const _StoragesUpdated({required this.storages});
  final List<Storage> storages;
}
