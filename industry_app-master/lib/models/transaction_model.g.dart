// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      created_at: DateTime.parse(json['created_at'] as String),
      id: json['id'] as int,
      counsumer_id: json['consumer_id'] as int,
      dustbin_id: json['dustbin_id'] as int,
      txn_amount: json['txn_amount'] as int,
      txn_title: json['txn_title'] as String,
      txn_type: json['txn_type'] as int,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'counsumer_id': instance.counsumer_id,
      'dustbin_id': instance.dustbin_id,
      'txn_title': instance.txn_title,
      'txn_amount': instance.txn_amount,
      'txn_type': instance.txn_type,
      'created_at': instance.created_at.toIso8601String(),
    };
