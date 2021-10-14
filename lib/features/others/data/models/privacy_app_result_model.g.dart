// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_app_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyAppResultModel _$PrivacyAppResultModelFromJson(
    Map<String, dynamic> json) {
  return PrivacyAppResultModel(
    details: json['details'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$PrivacyAppResultModelToJson(
        PrivacyAppResultModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
    };
