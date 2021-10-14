// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_app_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyAppResponse _$PrivacyAppResponseFromJson(Map<String, dynamic> json) {
  return PrivacyAppResponse(
    json['status'] as bool,
    json['msg'] as String,
    json['result'] = PrivacyAppResultModel.fromJson(
            json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PrivacyAppResponseToJson(PrivacyAppResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
