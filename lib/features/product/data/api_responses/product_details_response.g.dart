// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponse _$ProductDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return ProductDetailsResponse(
    json['status'] as bool,
    json['msg'] as String,
    json['result'] =
        ProductDetailsModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductDetailsResponseToJson(
        ProductDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
