import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()

class TransactionModel {
  int id;
  int counsumer_id;
  int dustbin_id;
  String txn_title;
  int txn_amount;
  int txn_type;
  DateTime created_at;

  TransactionModel({
    required this.created_at,
    required this.id,
    required this.counsumer_id,
    required this.dustbin_id,
    required this.txn_amount,
    required this.txn_title,
    required this.txn_type,
  });
  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

}
