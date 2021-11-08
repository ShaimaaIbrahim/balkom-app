import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coupon_code_model.g.dart';

@JsonSerializable()
class CouponCodeModel extends BaseModel<CouponCodeEntity> {
  @JsonKey(name: 'coupon_id')
  final int couponId;
  @JsonKey(name: 'discountamount')
  final String discountAmount;
  @JsonKey(name: 'discount')
  final String discount;
  @JsonKey(name: 'couponcode')
  final String couponCode;
  @JsonKey(name: 'total')
  final String total;
  @JsonKey(name: 'type')
  final int type;

  CouponCodeModel(
      {required this.total,
      required this.couponCode,
      required this.couponId,
      required this.discount,
      required this.discountAmount,
      required this.type});

  factory CouponCodeModel.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponCodeModelToJson(this);

  @override
  CouponCodeEntity toEntity() => CouponCodeEntity(
      couponCode: this.couponCode,
      couponId: this.couponId,
      discount: this.discount,
      discountAmount: this.discountAmount,
      total: this.total,
      type: this.type);
}
