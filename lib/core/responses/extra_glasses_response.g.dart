// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_glasses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraGlassesResponse _$ExtraGlassesResponseFromJson(Map<String, dynamic> json) {
  return ExtraGlassesResponse(
    json['status'] as bool,
    json['msg'] as String,
    ExtraGlassesModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExtraGlassesResponseToJson(
        ExtraGlassesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
