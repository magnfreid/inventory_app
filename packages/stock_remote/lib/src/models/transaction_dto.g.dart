// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    TransactionDto(
      id: json['id'] as String?,
      partId: json['partId'] as String,
      storageId: json['storageId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      note: json['note'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userDisplayName: json['userDisplayName'] as String? ?? '',
      partName: json['partName'] as String? ?? '',
      detailNumber: json['detailNumber'] as String? ?? '',
      storageName: json['storageName'] as String? ?? '',
      unitPriceSnapshot: (json['unitPriceSnapshot'] as num?)?.toDouble() ?? 0,
      isRecycledPart: json['isRecycledPart'] as bool? ?? false,
      destinationStorageId: json['destinationStorageId'] as String?,
      destinationStorageName: json['destinationStorageName'] as String?,
    );

Map<String, dynamic> _$TransactionDtoToJson(TransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partId': instance.partId,
      'storageId': instance.storageId,
      'userId': instance.userId,
      'userDisplayName': instance.userDisplayName,
      'partName': instance.partName,
      'detailNumber': instance.detailNumber,
      'storageName': instance.storageName,
      'unitPriceSnapshot': instance.unitPriceSnapshot,
      'isRecycledPart': instance.isRecycledPart,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'note': instance.note,
      'timestamp': instance.timestamp.toIso8601String(),
      'destinationStorageId': instance.destinationStorageId,
      'destinationStorageName': instance.destinationStorageName,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.use: 'use',
  TransactionType.restock: 'restock',
  TransactionType.adjustment: 'adjustment',
  TransactionType.transfer: 'transfer',
};
