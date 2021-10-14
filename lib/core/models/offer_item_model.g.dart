// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferItemModel _$OfferItemModelFromJson(Map<String, dynamic> json) {
  return OfferItemModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
    type: json['type'] as String?,
    is_glasses: json['is_glasses'] as bool?,
    discountPrice: json['discount_price'] as int?,
    discountType: json['discount_type'] as String?,
    discountTypeInt: json['discount_type_ int? '] as int?,
    info: json['info'] as String?,
    productId: json['product_id'] as int?,
  );
}

Map<String, dynamic> _$OfferItemModelToJson(OfferItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'info': instance.info,
      'discount_price': instance.discountPrice,
      'discount_type': instance.discountType,
      'discount_type_ int? ': instance.discountTypeInt,
      'product_id': instance.productId,
      'type': instance.type,
      'is_glasses': instance.is_glasses,
    };
