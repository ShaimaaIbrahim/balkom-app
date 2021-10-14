// GENERATED CODE - DO NOT MODIFY BY HAND
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    categoryId: json['category_id'] as int?,
    name: json['name'] as String?,
    id: json['id'] as int?,
    gender: json['Gender'] as String?,
    discountPrice: (json['discount_price'] as num?)?.toDouble(),
    discountTypeInt: json['discount_type_ int?'] as int?,
    discountType: json['discount_type'] as String?,
    type: json['type'] as int?,
    frameShape: json['FrameShape'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    description: json['description'] as String?,
    productReviews: (json['product_reviews'] as List<dynamic>?)
        ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    availability: json['avalability'] as bool?,
    brandId: json['brand_id'] as int?,
    isReview: json['isReview'] as bool?,
    brandInfo: json['brandInfo'] == null
        ? null
        : ItemModel.fromJson(json['brandInfo'] as Map<String, dynamic>),
    featured: json['Featured'] as bool?,
    genderId: json['Gender_id'] as int?,
    hasCouponCode: json['HasCoponCode'] as bool?,
    isNew: json['IsNew'] as bool?,
    lensesFree: json['lensesFree'] as bool?,
    image: json['image'] as String?,
    shapeframeinfo: (json['shapeframeinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    rate: json['rate'] as String?,
    isGlasses: json['Is_Glasses'] as bool?,
    shapeFaceInfo: (json['faceshapeinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeFaceInfo: (json['sizefaceinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sizeModeInfo: (json['sizesinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    colorInfo: (json['colorinfo'] as List<dynamic>?)
        ?.map((e) => GeneralItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    shopId: json['shop_id'] as int?,
    shopInfo: json['shopinfo'] == null
        ? null
        : ItemModel.fromJson(json['shopinfo'] as Map<String, dynamic>),
    typeProduct: json['type_product'] as String?,
    photoInfo: (json['photoinfo'] as List<dynamic>?)
        ?.map((e) => ImageInfoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    priceAfterDiscount: json['price_after_discount'] as String?,
    isFavorite: json['isFavorite'] as bool?,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
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
      'discount_type_ int?': instance.discountTypeInt,
      'type_product': instance.typeProduct,
      'Gender': instance.gender,
      'brandInfo': instance.brandInfo,
      'shopinfo': instance.shopInfo,
      'shapeframeinfo': instance.shapeframeinfo,
      'colorinfo': instance.colorInfo,
      'sizesinfo': instance.sizeModeInfo,
      'sizefaceinfo': instance.sizeFaceInfo,
      'faceshapeinfo': instance.shapeFaceInfo,
      'photoinfo': instance.photoInfo,
      'price_after_discount': instance.priceAfterDiscount,
      'isFavorite': instance.isFavorite,
      'isReview': instance.isReview,
      'product_reviews': instance.productReviews,
    };
