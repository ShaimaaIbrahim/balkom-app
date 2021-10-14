// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_glasses_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraGlassesItemModel _$ExtraGlassesItemModelFromJson(
    Map<String, dynamic> json) {
  return ExtraGlassesItemModel(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ExtraGlassesItemModelToJson(
        ExtraGlassesItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'image': instance.image,
    };
