import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class WalletTransactionsEntity extends BaseEntity {
  final int id;
  final int currency_id;
  final int opreate_type;
  final String type;
  final String? amount;
  final String? description;
  final String? opreate_name;
  final String TranslationType;

  WalletTransactionsEntity({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.currency_id,
    required this.opreate_name,
    required this.opreate_type,
    required this.TranslationType,
  });

  @override
  List<Object> get props => [
        id,
        type,
        description??'',
        amount??'',
        currency_id,
        opreate_name??'',
        opreate_type,
        TranslationType,
      ];
}
