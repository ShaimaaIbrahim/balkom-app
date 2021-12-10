import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

import 'general_item_entity.dart';
import 'image_info_entity.dart';
import 'item_entity.dart';
import 'product_entity.dart';
import 'review_entity.dart';

class ProductDetailsEntity extends BaseEntity {
  final int? id;
  final String? name;
  final String? image;
  double? price;
  final String? discountType;
  double? discountPrice;
  final String? frameShape;
  final int? type;
  final bool? isNew;
  final bool? isGlasses;

  final int? genderId;

  final int? shopId;

  final int? categoryId;

  final int? brandId;
  final String? description;

  final bool? hasCouponCode;

  final bool? availability;

  final bool? featured;

  final bool? lensesFree;
  final String? rate;

  final int? discountTypeInt;

  final String? typeProduct;

  final String? gender;

  bool? isFavorite;

  final ItemEntity? brandInfo;

  final ItemEntity? shopInfo;

  final List<GeneralItemEntity>? shapeframeinfo;

  final List<GeneralItemEntity>? colorInfo;

  final List<GeneralItemEntity>? sizeModeInfo;

  final List<GeneralItemEntity>? sizeFaceInfo;

  final List<GeneralItemEntity>? shapeFaceInfo;

  final List<ImageInfoEntity>? photoInfo;

  final List<ReviewEntity>? productReviews;

  final List<ProductEntity>? productAsSame;

  ProductDetailsEntity({
    required this.categoryId,
    required this.name,
    required this.id,
    required this.gender,
    required this.discountPrice,
    required this.discountTypeInt,
    required this.discountType,
    required this.type,
    required this.frameShape,
    required this.price,
    required this.description,
    required this.availability,
    required this.brandId,
    required this.brandInfo,
    required this.featured,
    required this.genderId,
    required this.hasCouponCode,
    required this.isNew,
    required this.lensesFree,
    required this.image,
    required this.shapeframeinfo,
    required this.rate,
    required this.isGlasses,
    required this.sizeFaceInfo,
    required this.sizeModeInfo,
    required this.colorInfo,
    required this.shapeFaceInfo,
    required this.shopId,
    required this.shopInfo,
    required this.typeProduct,
    required this.photoInfo,
    required this.isFavorite,
    required this.productReviews,
    required this.productAsSame,
  });

  @override
  List<Object> get props => [
        categoryId!,
        name!,
        id!,
        gender!,
        discountPrice!,
        discountTypeInt!,
        discountType!,
        type!,
        frameShape!,
        price!,
        description!,
        availability!,
        brandId!,
        brandInfo!,
        featured!,
        genderId!,
        hasCouponCode!,
        lensesFree!,
        image!,
        shapeframeinfo!,
        rate!,
        isGlasses ?? '',
        sizeFaceInfo!,
        sizeModeInfo!,
        colorInfo!,
        shapeFaceInfo!,
        shopId!,
        shopInfo!,
        typeProduct!,
        photoInfo!,
        isFavorite!,
        productReviews!,
        productAsSame!,
      ];
}
