// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_glasses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraGlassesModel _$ExtraGlassesModelFromJson(Map<String, dynamic> json) {
  return ExtraGlassesModel(
    colors: (json['Colors'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    frameShape: (json['FrameShape'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    gender: (json['Gender'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    lensesType: (json['lenseType'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    shapeFace: (json['ShapeFace'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeMode: (json['SizeMode'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeFace: (json['SizeFace'] as List<dynamic>?)
        ?.map((e) => ExtraGlassesItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ExtraGlassesModelToJson(ExtraGlassesModel instance) =>
    <String, dynamic>{
      'lenseType': instance.lensesType,
      'Gender': instance.gender,
      'FrameShape': instance.frameShape,
      'Colors': instance.colors,
      'SizeFace': instance.sizeFace,
      'ShapeFace': instance.shapeFace,
      'SizeMode': instance.sizeMode,
    };
