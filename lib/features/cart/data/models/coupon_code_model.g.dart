// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCodeModel _$CouponCodeModelFromJson(Map<String, dynamic> json) {
  return CouponCodeModel(
      total: json['total'] as String,
      couponCode: json['couponcode'] as String,
      couponId: json['coupon_id'] as int,
      discount: json['discount'] as String,
      discountAmount: json['discountamount'] as String,
      type: json['type'] as int);
}

Map<String, dynamic> _$CouponCodeModelToJson(CouponCodeModel instance) =>
    <String, dynamic>{
      'coupon_id': instance.couponId,
      'discountamount': instance.discountAmount,
      'discount': instance.discount,
      'couponcode': instance.couponCode,
      'total': instance.total,
      'type': instance.type
    };
