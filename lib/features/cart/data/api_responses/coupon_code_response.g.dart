// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCodeResponse _$CouponCodeResponseFromJson(Map<String, dynamic> json) {
  return CouponCodeResponse(
    json['status'] as bool,
    json['msg'] as String,
    json['result'] =
        CouponCodeModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CouponCodeResponseToJson(CouponCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
