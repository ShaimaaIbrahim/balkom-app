import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/product/data/models/general_item_model.dart';
import 'package:ojos_app/features/product/domin/entities/general_item_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_info_item_entity.dart';

part 'product_info_item_model.g.dart';

@JsonSerializable()
class ProductInfoItemModel extends BaseModel<ProductInfoItemEntity> {
  final int id;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'Color_id')
  final int colorId;
  @JsonKey(name: 'SizeMode')
  final int sizeMode;
  @JsonKey(name: 'SizeFace')
  final int sizeFace;
  @JsonKey(name: 'ShapeFace')
  final int shapeFace;
  @JsonKey(name: 'LensWidth')
  final int lensWidth;
  @JsonKey(name: 'LensHeight')
  final int lensHeight;
  @JsonKey(name: 'BridgeWidth')
  final int bridgeWidth;
  @JsonKey(name: 'TempleLength')
  final int templeLength;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: 'front_img')
  final String frontImg;
  @JsonKey(name: '180_img')
  final String the180Img;
  @JsonKey(name: '90_img')
  final String the90Img;
  @JsonKey(name: '45_img')
  final String the45Img;
  @JsonKey(name: 'person_img')
  final String personImg;
  @JsonKey(name: 'try_img')
  final String tryImg;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'colorinfo')
  final List<GeneralItemModel> colorInfo;
  @JsonKey(name: 'sizemodeinfo')
  final List<GeneralItemModel> sizeModeInfo;
  @JsonKey(name: 'sizefaceinfo')
  final List<GeneralItemModel> sizeFaceInfo;
  @JsonKey(name: 'shapefaceinfo')
  final List<GeneralItemModel> shapeFaceInfo;

  ProductInfoItemModel({
    required this.id,
    required this.productId,
    required this.sizeMode,
    required this.sizeFace,
    required this.shapeFace,
    required this.categoryId,
    required this.bridgeWidth,
    required this.colorId,
    required this.colorInfo,
    required this.frontImg,
    required this.lensHeight,
    required this.lensWidth,
    required this.personImg,
    required this.quantity,
    required this.shapeFaceInfo,
    required this.sizeFaceInfo,
    required this.sizeModeInfo,
    required this.templeLength,
    required this.the45Img,
    required this.the90Img,
    required this.the180Img,
    required this.tryImg,
  });

  factory ProductInfoItemModel.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInfoItemModelToJson(this);

  @override
  ProductInfoItemEntity toEntity() => ProductInfoItemEntity(
      id: this.id,
      personImg: this.personImg,
      productId: this.productId,
      bridgeWidth: this.bridgeWidth,
      categoryId: this.categoryId,
      colorId: this.colorId,
      colorInfo:  this.colorInfo != null
          ? this.colorInfo.map((t) => t.toEntity()).toList()
          : [],
      shapeFaceInfo:  this.shapeFaceInfo != null
          ? this.shapeFaceInfo.map((t) => t.toEntity()).toList()
          : [],
      sizeFaceInfo:  this.sizeFaceInfo != null
          ? this.sizeFaceInfo.map((t) => t.toEntity()).toList()
          : [],
      sizeModeInfo:  this.sizeModeInfo != null
          ? this.sizeModeInfo.map((t) => t.toEntity()).toList()
          : [],
      frontImg: this.frontImg,
      lensHeight: this.lensHeight,
      lensWidth: this.lensWidth,
      quantity: this.quantity,
      shapeFace: this.shapeFace,
      sizeFace: this.sizeFace,
      sizeMode: this.sizeMode,
      templeLength: this.templeLength,
      the45Img: this.the45Img,
      the90Img: this.the90Img,
      the180Img: this.the180Img,
      tryImg: this.tryImg);
}
