part of 'part_details_bloc.dart';

sealed class PartDetailsEvent {
  const PartDetailsEvent();
}

final class _PartUpdated extends PartDetailsEvent {
  const _PartUpdated({required this.part});
  final PartPresentation? part;
}

final class _OnStreamError extends PartDetailsEvent {
  const _OnStreamError({required this.error});
  final RemoteException error;
}

final class _StoragesUpdated extends PartDetailsEvent {
  _StoragesUpdated({required this.storages});
  final List<Storage> storages;
}

final class UseButtonPressed extends PartDetailsEvent {
  const UseButtonPressed({
    required this.partId,
    required this.storageId,
    required this.userId,
    required this.note,
  });
  final String partId;
  final String storageId;
  final String userId;
  final String note;
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
    required this.userId,
    required this.note,
  });
  final String partId;
  final String storageId;
  final int amount;
  final String userId;
  final String? note;
}
