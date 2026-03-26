part of 'part_details_bloc.dart';

sealed class PartDetailsEvent {
  const PartDetailsEvent();
}

final class _PartUpdated extends PartDetailsEvent {
  const _PartUpdated({required this.part});
  final PartPresentation part;
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
    required this.userId,
    required this.storageId,
    required this.message,
  });

  final String userId;
  final String storageId;
  final String message;
}

final class ConfirmDeletePartButtonPressed extends PartDetailsEvent {
  const ConfirmDeletePartButtonPressed({required this.partId});
  final String partId;
}

final class AddToStockButtonPressed extends PartDetailsEvent {
  const AddToStockButtonPressed({
    required this.storageId,
    required this.amount,
    required this.userId,
    required this.note,
  });
  final String storageId;
  final int amount;
  final String userId;
  final String? note;
}

final class ImageSelected extends PartDetailsEvent {
  const ImageSelected({required this.deviceImgPath});
  final String deviceImgPath;
}

final class ConfirmDeleteImageButtonPressed extends PartDetailsEvent {
  const ConfirmDeleteImageButtonPressed({required this.part});
  final PartPresentation part;
}
