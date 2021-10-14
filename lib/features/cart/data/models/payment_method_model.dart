import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/features/cart/domin/entities/payment_method_entity.dart';
part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel extends BaseModel<PaymentMethodEntity> {
  final int id;
  final String key;
  final String name;
  final String image;

  PaymentMethodModel({
    required this.name,
    required this.image,
    required this.id,
    required this.key,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);

  @override
  PaymentMethodEntity toEntity() => PaymentMethodEntity(
      name: this.name, image: this.image, id: this.id, key: this.key);
}
