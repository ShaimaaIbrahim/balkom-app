// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfoModel _$ImageInfoModelFromJson(Map<String, dynamic> json) {
  return ImageInfoModel(
    id: json['id'] as int,
    productId: json['productId'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$ImageInfoModelToJson(ImageInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'image': instance.image,
    };
