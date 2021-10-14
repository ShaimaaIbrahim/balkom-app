import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/product/data/models/general_item_model.dart';
import 'package:ojos_app/features/product/data/models/image_info_model.dart';
import 'package:ojos_app/features/product/data/models/item_model.dart';
import 'package:ojos_app/features/product/data/models/product_info_item_model.dart';
import 'package:ojos_app/features/product/domin/entities/item_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';

import 'review_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends BaseModel<ProductEntity> {
  final int? id;
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  final double? price;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'discount_price')
  final double? discountPrice;
  @JsonKey(name: 'FrameShape')
  final String? frameShape;
  final int? type;
  @JsonKey(name: 'IsNew')
  final bool? isNew;
  @JsonKey(name: 'Is_Glasses')
  final bool? isGlasses;
  @JsonKey(name: 'Gender_id')
  final int? genderId;
  @JsonKey(name: 'shop_id')
  final int? shopId;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @JsonKey(name: 'brand_id')
  final int? brandId;
  final String? description;
  @JsonKey(name: 'HasCoponCode')
  final bool? hasCouponCode;
  @JsonKey(name: 'avalability')
  final bool? availability;
  @JsonKey(name: 'Featured')
  final bool? featured;
  @JsonKey(name: 'lensesFree')
  final bool? lensesFree;
  final String? rate;
  @JsonKey(name: 'discount_type_int')
  final int? discountTypeInt;
  @JsonKey(name: 'type_product')
  final String? typeProduct;
  @JsonKey(name: 'Gender')
  final String? gender;
  @JsonKey(name: 'brandInfo')
  final ItemModel? brandInfo;
  @JsonKey(name: 'shopinfo')
  final ItemModel? shopInfo;
  @JsonKey(name: 'shapeframeinfo')
  final List<GeneralItemModel>? shapeframeinfo;
  @JsonKey(name: 'colorinfo')
  final List<GeneralItemModel>? colorInfo;
  @JsonKey(name: 'sizesinfo')
  final List<GeneralItemModel>? sizeModeInfo;
  @JsonKey(name: 'sizefaceinfo')
  final List<GeneralItemModel>? sizeFaceInfo;
  @JsonKey(name: 'faceshapeinfo')
  final List<GeneralItemModel>? shapeFaceInfo;

  @JsonKey(name: 'photoinfo')
  final List<ImageInfoModel>? photoInfo;

  @JsonKey(name: 'price_after_discount')
  final String? priceAfterDiscount;
  @JsonKey(name: 'isFavorite')
  final bool? isFavorite;
  final bool? isReview;
  @JsonKey(name: 'product_reviews')
  final List<ReviewModel>? productReviews;
  ProductModel({
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
    required this.productReviews,
    required this.availability,
    required this.brandId,
    required this.isReview,
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
    required this.shapeFaceInfo,
    required this.sizeFaceInfo,
    required this.sizeModeInfo,
    required this.colorInfo,
    required this.shopId,
    required this.shopInfo,
    required this.typeProduct,
    required this.photoInfo,
    required this.priceAfterDiscount,
    required this.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  ProductEntity toEntity() => ProductEntity(
        id: this.id,
        name: this.name,
        categoryId: this.categoryId,
        discountType: this.discountType,
        discountPrice: this.discountPrice,
        type: this.type,
        price: this.price,
        description: this.description,
        availability: this.availability,
        brandId: this.brandId,
        isReview: this.isReview,
        discountTypeInt: this.discountTypeInt,
        featured: this.featured,
        frameShape: this.frameShape,
        gender: this.gender,
        genderId: this.genderId,
        hasCouponCode: this.hasCouponCode,
        isNew: this.isNew,
        lensesFree: this.lensesFree,
        image: this.image,
        rate: this.rate,
        isGlasses: this.isGlasses,
        shopId: this.shopId,
        isFavorite: this.isFavorite,
        typeProduct: this.typeProduct,
        brandInfo: this.brandInfo != null
            ? this.brandInfo!.toEntity()
            : ItemEntity(id: null, name: null),
        shopInfo: this.shopInfo != null
            ? this.shopInfo!.toEntity()
            : ItemEntity(id: null, name: null),
        colorInfo: this.colorInfo != null
            ? this.colorInfo!.map((t) => t.toEntity()).toList()
            : [],
        shapeFaceInfo: this.shapeFaceInfo != null
            ? this.shapeFaceInfo!.map((t) => t.toEntity()).toList()
            : [],
        shapeframeinfo: this.shapeframeinfo != null
            ? this.shapeframeinfo!.map((t) => t.toEntity()).toList()
            : [],
        sizeFaceInfo: this.sizeFaceInfo != null
            ? this.sizeFaceInfo!.map((t) => t.toEntity()).toList()
            : [],
        sizeModeInfo: this.sizeModeInfo != null
            ? this.sizeModeInfo!.map((t) => t.toEntity()).toList()
            : [],
        photoInfo: this.photoInfo != null
            ? this.photoInfo!.map((t) => t.toEntity()).toList()
            : [],
        productReviews: this.productReviews != null
            ? this.productReviews!.map((t) => t.toEntity()).toList()
            : [],
      );
}
