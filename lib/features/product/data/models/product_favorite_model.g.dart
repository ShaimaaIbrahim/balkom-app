// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFavoriteModel _$ProductFavoriteModelFromJson(Map<String, dynamic> json) {
  return ProductFavoriteModel(
    product: json['product'] == null
        ? null
        : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductFavoriteModelToJson(
        ProductFavoriteModel instance) =>
    <String, dynamic>{
      'product': instance.product,
    };
