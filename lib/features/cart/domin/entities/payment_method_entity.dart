import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class PaymentMethodEntity extends BaseEntity {
  final int id;
  final String key;
  final String name;
  final String image;

  PaymentMethodEntity({
    required this.name,
    required this.image,
    required this.id,
    required this.key,
  });

  @override
  List<Object> get props => [
        name,
        image,
        id,
        key,
      ];
}
