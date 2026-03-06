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

final class UseButtonPressed extends PartDetailsEvent {
  const UseButtonPressed({required this.partId, required this.storageId});
  final String partId;
  final String storageId;
}

final class ButtonSegmentPressed extends PartDetailsEvent {
  const ButtonSegmentPressed({required this.content});
  final PartDetailsContent content;
}

final class ConfirmDeleteButtonPressed extends PartDetailsEvent {
  const ConfirmDeleteButtonPressed({required this.partId});
  final String partId;
}

final class AddToStockButtonPressed extends PartDetailsEvent {
  const AddToStockButtonPressed({
    required this.partId,
    required this.storageId,
    required this.amount,
  });
  final String partId;
  final String storageId;
  final int amount;
}
