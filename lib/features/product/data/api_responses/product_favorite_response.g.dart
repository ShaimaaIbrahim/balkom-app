// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFavoriteResponse _$ProductFavoriteResponseFromJson(
    Map<String, dynamic> json) {
  return ProductFavoriteResponse(
      json['status'] as bool,
      json['msg'] as String,
      (json['result'] as List)
          .map((e) => ProductFavoriteModel.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$ProductFavoriteResponseToJson(
        ProductFavoriteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
