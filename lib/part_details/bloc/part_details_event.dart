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
    required this.userDisplayName,
    required this.storageId,
    required this.message,
  });

  final String userId;

  /// Display name snapshotted onto the transaction (denormalized).
  final String userDisplayName;

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
    required this.userDisplayName,
    required this.note,
  });
  final String storageId;
  final int amount;
  final String userId;

  /// Display name snapshotted onto the transaction (denormalized).
  final String userDisplayName;

  final String? note;
}

/// Dispatched when the user confirms a stock transfer between two storages.
final class TransferStockButtonPressed extends PartDetailsEvent {
  /// Creates a [TransferStockButtonPressed] event.
  const TransferStockButtonPressed({
    required this.fromStorageId,
    required this.toStorageId,
    required this.quantity,
    required this.userId,
    required this.userDisplayName,
    this.note,
  });

  /// Identifier of the storage to transfer stock from.
  final String fromStorageId;

  /// Identifier of the storage to transfer stock to.
  final String toStorageId;

  /// Number of units to transfer. Must be greater than zero.
  final int quantity;

  /// Identifier of the user performing the transfer.
  final String userId;

  /// Display name of the user snapshotted onto both transaction records.
  final String userDisplayName;

  /// Optional note describing the reason for the transfer.
  final String? note;
}

final class ImageSelected extends PartDetailsEvent {
  const ImageSelected({required this.file});
  final XFile file;
}

final class ConfirmDeleteImageButtonPressed extends PartDetailsEvent {
  const ConfirmDeleteImageButtonPressed({required this.part});
  final PartPresentation part;
}
