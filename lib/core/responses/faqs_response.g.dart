// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqsResponse _$FaqsResponseFromJson(Map<String, dynamic> json) {
  return FaqsResponse(
    json['status'] as bool,
    json['msg'] as String,
    (json['result'] as List<dynamic>)
        .map((e) => FaqsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FaqsResponseToJson(FaqsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
