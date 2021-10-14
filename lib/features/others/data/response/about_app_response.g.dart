// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_app_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutAppResponse _$AboutAppResponseFromJson(Map<String, dynamic> json) {
  return AboutAppResponse(
    json['status'] as bool,
    json['msg'] as String,
    json['result'] =
        AboutAppResultModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AboutAppResponseToJson(AboutAppResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
