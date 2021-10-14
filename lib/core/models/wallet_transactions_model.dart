import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/wallet_transactions_entity.dart';
import 'package:ojos_app/core/models/base_model.dart';

part 'wallet_transactions_model.g.dart';

@JsonSerializable()
class WalletTransactionsModel extends BaseModel<WalletTransactionsEntity> {
  final int id;
  final int currency_id;
  final int opreate_type;
  final String type;
  final String amount;
  final String description;
  final String opreate_name;
  final String TranslationType;

  WalletTransactionsModel({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.currency_id,
    required this.opreate_name,
    required this.opreate_type,
    required this.TranslationType,
  });

  //
  factory WalletTransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionsModelToJson(this);

  @override
  WalletTransactionsEntity toEntity() => WalletTransactionsEntity(
      id: this.id,
      type: this.type,
      amount: this.amount,
      description: this.description,
      currency_id: this.currency_id,
      opreate_name: this.opreate_name,
      opreate_type: this.opreate_type,
      TranslationType: this.TranslationType);
}
