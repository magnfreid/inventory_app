// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    TransactionDto._(
      id: json['id'] as String?,
      partId: json['partId'] as String,
      storageId: json['storageId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      note: json['note'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TransactionDtoToJson(TransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partId': instance.partId,
      'storageId': instance.storageId,
      'userId': instance.userId,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'note': instance.note,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.use: 'use',
  TransactionType.restock: 'restock',
  TransactionType.adjustment: 'adjustment',
};
