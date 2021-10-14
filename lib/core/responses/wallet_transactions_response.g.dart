// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transactions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransactionsResponse _$WalletTransactionsResponseFromJson(
    Map<String, dynamic> json) {
  return WalletTransactionsResponse(
    json['status'] as bool,
    json['msg'] as String,
    (json['result'] as List<dynamic>)
        .map((e) => WalletTransactionsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WalletTransactionsResponseToJson(
        WalletTransactionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
