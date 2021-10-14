// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyResponse _$EmptyResponseFromJson(Map<String, dynamic> json) {
  return EmptyResponse(json['status'] as bool, json['msg'] as String, Null);
}

Map<String, dynamic> _$EmptyResponseToJson(EmptyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
