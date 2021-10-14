// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralItemModel _$GeneralItemModelFromJson(Map<String, dynamic> json) {
  return GeneralItemModel(
    id: json['id'] as int,
    name: json['name'] as String,
    value: json['value'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$GeneralItemModelToJson(GeneralItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'image': instance.image,
    };
