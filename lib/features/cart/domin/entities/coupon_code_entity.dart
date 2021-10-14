import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class CouponCodeEntity extends BaseEntity {
  final int couponId;
  final String discountAmount;
  final String discount;
  final String couponCode;
  final String total;

  CouponCodeEntity({
    required this.total,
    required this.couponCode,
    required this.couponId,
    required this.discount,
    required this.discountAmount,
  });

  @override
  List<Object> get props => [
        total,
        couponCode,
        couponId,
        discount,
        discountAmount,
      ];
}
