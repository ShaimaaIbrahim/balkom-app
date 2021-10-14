import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:ojos_app/features/product/domin/entities/general_item_entity.dart';

class ProductInfoItemEntity extends BaseEntity {
  final int id;
  final int productId;
  final int colorId;
  final int sizeMode;
  final int sizeFace;
  final int shapeFace;
  final int lensWidth;
  final int lensHeight;
  final int bridgeWidth;
  final int templeLength;
  final int quantity;
  final String frontImg;
  final String the180Img;
  final String the90Img;
  final String the45Img;
  final String personImg;
  final String tryImg;
  final int categoryId;
  final List<GeneralItemEntity> colorInfo;
  final List<GeneralItemEntity> sizeModeInfo;
  final List<GeneralItemEntity> sizeFaceInfo;
  final List<GeneralItemEntity> shapeFaceInfo;

  ProductInfoItemEntity({
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

  @override
  List<Object> get props => [
        id,
        productId,
        sizeMode,
        sizeFace,
        shapeFace,
        categoryId,
        bridgeWidth,
        colorId,
        colorInfo,
        frontImg,
        lensHeight,
        lensWidth,
        personImg,
        quantity,
        shapeFaceInfo,
        sizeFaceInfo,
        sizeModeInfo,
        templeLength,
        the45Img,
        the90Img,
        the180Img,
        tryImg,
      ];
}
