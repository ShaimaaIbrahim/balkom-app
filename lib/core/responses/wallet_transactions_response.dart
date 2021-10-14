import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/wallet_transactions_model.dart';
import 'package:ojos_app/core/responses/api_response.dart';

part 'wallet_transactions_response.g.dart';

@JsonSerializable()
class WalletTransactionsResponse
    extends ApiResponse<List<WalletTransactionsModel>> {
  WalletTransactionsResponse(
    bool status,
    String msg,
    List<WalletTransactionsModel> result,
  ) : super(status, msg, result);
  //
  factory WalletTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionsResponseFromJson(json);
}
