// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetResponse _$ForgetResponseFromJson(Map<String, dynamic> json) {
  return ForgetResponse(
    json['status'] as bool,
    json['msg'] as String,
    json['result'] =
        ForgetResultModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ForgetResponseToJson(ForgetResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
