// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsResponse _$BrandsResponseFromJson(Map<String, dynamic> json) {
  return BrandsResponse(
    json['status'] as bool,
    json['msg'] as String,
    (json['result'] as List<dynamic>)
        .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BrandsResponseToJson(BrandsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
