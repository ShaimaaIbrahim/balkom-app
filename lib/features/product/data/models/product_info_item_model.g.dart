// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfoItemModel _$ProductInfoItemModelFromJson(Map<String, dynamic> json) {
  return ProductInfoItemModel(
    id: json['id'] as int,
    productId: json['product_id'] as int,
    sizeMode: json['SizeMode'] as int,
    sizeFace: json['SizeFace'] as int,
    shapeFace: json['ShapeFace'] as int,
    categoryId: json['category_id'] as int,
    bridgeWidth: json['BridgeWidth'] as int,
    colorId: json['Color_id'] as int,
    colorInfo: (json['colorinfo'] as List)
        .map((e) => e = GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    frontImg: json['front_img'] as String,
    lensHeight: json['LensHeight'] as int,
    lensWidth: json['LensWidth'] as int,
    personImg: json['person_img'] as String,
    quantity: json['quantity'] as int,
    shapeFaceInfo: (json['shapefaceinfo'] as List)
        .map((e) => e = GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeFaceInfo: (json['sizefaceinfo'] as List)
        .map((e) => e = GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeModeInfo: (json['sizemodeinfo'] as List)
        .map((e) => e = GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    templeLength: json['TempleLength'] as int,
    the45Img: json['45_img'] as String,
    the90Img: json['90_img'] as String,
    the180Img: json['180_img'] as String,
    tryImg: json['try_img'] as String,
  );
}

Map<String, dynamic> _$ProductInfoItemModelToJson(
        ProductInfoItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'Color_id': instance.colorId,
      'SizeMode': instance.sizeMode,
      'SizeFace': instance.sizeFace,
      'ShapeFace': instance.shapeFace,
      'LensWidth': instance.lensWidth,
      'LensHeight': instance.lensHeight,
      'BridgeWidth': instance.bridgeWidth,
      'TempleLength': instance.templeLength,
      'quantity': instance.quantity,
      'front_img': instance.frontImg,
      '180_img': instance.the180Img,
      '90_img': instance.the90Img,
      '45_img': instance.the45Img,
      'person_img': instance.personImg,
      'try_img': instance.tryImg,
      'category_id': instance.categoryId,
      'colorinfo': instance.colorInfo,
      'sizemodeinfo': instance.sizeModeInfo,
      'sizefaceinfo': instance.sizeFaceInfo,
      'shapefaceinfo': instance.shapeFaceInfo,
    };
