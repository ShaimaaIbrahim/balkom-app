// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_carriers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingCarriersResponse _$ShippingCarriersResponseFromJson(
    Map<String, dynamic> json) {
  return ShippingCarriersResponse(
    json['status'] as bool,
    json['msg'] as String,
    (json['result'] as List<dynamic>)
        .map((e) => ShippingCarriersModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShippingCarriersResponseToJson(
        ShippingCarriersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
