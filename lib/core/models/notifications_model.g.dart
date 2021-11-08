// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) {
  return NotificationsModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      icon: json['icon'],
      id_s: json['id_s'],
      id: json['id'] as String?,
      type: json['type'],
      type_int: json['type_int'] as int?);
}

Map<String, dynamic> _$NotificationsModelToJson(NotificationsModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'id_s': instance.id_s,
      'icon': instance.icon,
      'title': instance.title,
      'id': instance.id,
      'type': instance.type,
      'type_int': instance.type_int
    };
