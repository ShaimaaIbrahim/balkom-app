import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:ojos_app/features/product/domin/entities/review_entity.dart';

import 'general_item_entity.dart';
import 'image_info_entity.dart';
import 'item_entity.dart';

class ProductEntity extends BaseEntity {
  final int? id;
  final String? name;

  final String? image;
  final double? price;

  final String? discountType;

  final double? discountPrice;

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
  final ItemEntity? brandInfo;
  final ItemEntity? shopInfo;
  final List<GeneralItemEntity>? shapeframeinfo;
  final List<GeneralItemEntity>? colorInfo;
  final List<GeneralItemEntity>? sizeModeInfo;
  final List<GeneralItemEntity>? sizeFaceInfo;
  final List<GeneralItemEntity>? shapeFaceInfo;
  final List<ImageInfoEntity>? photoInfo;
  bool? isFavorite;
  final bool? isReview;
  final List<ReviewEntity>? productReviews;
  ProductEntity({
    this.categoryId,
    this.name,
    this.id,
    this.gender,
    required this.discountPrice,
    this.discountTypeInt,
    this.discountType,
    this.type,
    this.frameShape,
    this.price,
    this.description,
    this.availability,
    this.brandId,
    this.productReviews,
    this.brandInfo,
    this.featured,
    this.genderId,
    this.isReview,
    this.hasCouponCode,
    this.isNew,
    this.lensesFree,
    this.image,
    this.colorInfo,
    this.rate,
    this.isGlasses,
    this.sizeModeInfo,
    this.sizeFaceInfo,
    this.shapeFaceInfo,
    this.shapeframeinfo,
    this.shopId,
    this.shopInfo,
    this.typeProduct,
    this.photoInfo,
    this.isFavorite,
  });

  @override
  List<Object> get props => [
        categoryId ?? '',
        name ?? '',
        id ?? '',
        gender ?? '',
        discountPrice ?? '',
        discountTypeInt ?? '',
        discountType ?? '',
        type ?? '',
        frameShape ?? '',
        productReviews ?? '',
        price ?? '',
        description ?? '',
        availability ?? '',
        brandId ?? '',
        isReview ?? '',
        brandInfo ?? '',
        featured ?? '',
        genderId ?? '',
        hasCouponCode ?? '',
        isNew ?? '',
        lensesFree ?? '',
        image ?? '',
        colorInfo ?? '',
        rate ?? '',
        isGlasses ?? '',
        sizeModeInfo ?? '',
        sizeFaceInfo ?? '',
        shapeFaceInfo ?? '',
        shapeframeinfo ?? '',
        shopId ?? '',
        shopInfo ?? '',
        typeProduct ?? '',
        photoInfo ?? '',
        isFavorite ?? '',
      ];
}
