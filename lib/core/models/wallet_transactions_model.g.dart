// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transactions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransactionsModel _$WalletTransactionsModelFromJson(
    Map<String, dynamic> json) {
  return WalletTransactionsModel(
    id: json['id'] as int,
    type: json['type'] as String,
    description: json['description'] as String,
    amount: json['amount'] as String,
    currency_id: json['currency_id'] as int,
    opreate_name: json['opreate_name'] as String,
    opreate_type: json['opreate_type'] as int,
    TranslationType: json['TranslationType'] as String,
  );
}

Map<String, dynamic> _$WalletTransactionsModelToJson(
        WalletTransactionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency_id': instance.currency_id,
      'opreate_type': instance.opreate_type,
      'type': instance.type,
      'amount': instance.amount,
      'description': instance.description,
      'opreate_name': instance.opreate_name,
      'TranslationType': instance.TranslationType,
    };
