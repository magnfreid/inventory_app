part of 'part_details_bloc.dart';

sealed class PartDetailsEvent {
  const PartDetailsEvent();
}

final class _PartUpdated extends PartDetailsEvent {
  const _PartUpdated({required this.part});
  final PartPresentation? part;
}

final class _StoragesUpdated extends PartDetailsEvent {
  _StoragesUpdated({required this.storages});
  final List<Storage> storages;
}

final class ShowAddViewButtonPressed extends PartDetailsEvent {
  const ShowAddViewButtonPressed();
}

final class SaveButtonPressed extends PartDetailsEvent {
  const SaveButtonPressed({
    required this.partId,
    required this.storageId,
    required this.amount,
  });
  final String partId;
  final String storageId;
  final int amount;
}
