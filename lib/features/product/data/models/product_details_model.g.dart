// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) {
  return ProductDetailsModel(
    categoryId: json['category_id'] as int?,
    name: json['name'] as String?,
    id: json['id'] as int?,
    gender: json['Gender'] as String?,
    discountPrice: (json['discount_price'] as num?)?.toDouble(),
    discountTypeInt: json['discount_type_int'] as int?,
    discountType: json['discount_type'] as String?,
    type: json['type'] as int?,
    frameShape: json['FrameShape'] as String?,
    price: (json['price'] as num).toDouble(),
    description: json['description'] as String?,
    availability: json['avalability'] as bool?,
    brandId: json['brand_id'] as int?,
    brandInfo: json['brandInfo'] == null
        ? null
        : ItemModel.fromJson(json['brandInfo'] as Map<String, dynamic>),
    featured: json['Featured'] as bool?,
    genderId: json['Gender_id'] as int?,
    hasCouponCode: json['HasCoponCode'] as bool?,
    isNew: json['IsNew'] as bool?,
    lensesFree: json['lensesFree'] as bool?,
    image: json['image'] as String?,
    shapeFaceInfo: (json['faceshapeinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    rate: json['rate'] as String?,
    isGlasses: json['Is_Glasses'] as bool?,
    colorInfo: (json['colorinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeModeInfo: (json['sizesinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeFaceInfo: (json['sizefaceinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    shapeframeinfo: (json['shapeframeinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    shopId: json['shop_id'] as int?,
    shopInfo: json['shopInfo'] == null
        ? null
        : ItemModel.fromJson(json['shopInfo'] as Map<String, dynamic>),
    typeProduct: json['type_product'] as String?,
    photoInfo: (json['photoinfo'] as List<dynamic>?)
        ?.map((e) => ImageInfoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    isFavorite: json['isFavorite'] as bool?,
    productReviews: (json['product_reviews'] as List<dynamic>?)
        ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    productAsSame: (json['product_as_same'] as List<dynamic>?)
        ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'discount_type': instance.discountType,
      'discount_price': instance.discountPrice,
      'FrameShape': instance.frameShape,
      'type': instance.type,
      'IsNew': instance.isNew,
      'Is_Glasses': instance.isGlasses,
      'Gender_id': instance.genderId,
      'shop_id': instance.shopId,
      'category_id': instance.categoryId,
      'brand_id': instance.brandId,
      'description': instance.description,
      'HasCoponCode': instance.hasCouponCode,
      'avalability': instance.availability,
      'Featured': instance.featured,
      'lensesFree': instance.lensesFree,
      'rate': instance.rate,
      'discount_type_int': instance.discountTypeInt,
      'type_product': instance.typeProduct,
      'Gender': instance.gender,
      'isFavorite': instance.isFavorite,
      'brandInfo': instance.brandInfo,
      'shopInfo': instance.shopInfo,
      'shapeframeinfo': instance.shapeframeinfo,
      'colorinfo': instance.colorInfo,
      'sizesinfo': instance.sizeModeInfo,
      'sizefaceinfo': instance.sizeFaceInfo,
      'faceshapeinfo': instance.shapeFaceInfo,
      'photoinfo': instance.photoInfo,
      'product_reviews': instance.productReviews,
      'product_as_same': instance.productAsSame,
    };
