import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/order/domain/entities/order_item_entity.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel extends BaseModel<OrderItemEntity> {
  final int? id;
  final int? user_id;
  final int? order_id;
  final int? product_id;
  final int? type_product;
  final int? quantity;
  final int? price;
  final int? RightSPH;
  final int? RightCYL;
  final int? RightAXI;
  final int? RightNear;
  final int? LeftSPH;
  final int? LeftCYL;
  final int? LeftAXI;
  final int? LeftNear;
  final int? APD;
  final int? IPD;
  final String? created_at;
  final String? updated_at;
  final ProductModel? product;

  OrderItemModel({
    required this.product,
    required this.quantity,
    required this.id,
    required this.APD,
    required this.created_at,
    required this.IPD,
    required this.LeftAXI,
    required this.LeftCYL,
    required this.LeftNear,
    required this.price,
    required this.LeftSPH,
    required this.order_id,
    required this.product_id,
    required this.RightAXI,
    required this.RightCYL,
    required this.RightNear,
    required this.RightSPH,
    required this.type_product,
    required this.updated_at,
    required this.user_id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  @override
  OrderItemEntity toEntity() => OrderItemEntity(
      id: this.id,
      user_id: this.user_id,
      product: this.product != null
          ? this.product!.toEntity()
          : ProductEntity(
              categoryId: null,
              name: null,
              id: null,
              gender: null,
              discountPrice: null,
              discountTypeInt: null,
              discountType: null,
              type: null,
              frameShape: null,
              price: null,
              description: null,
              availability: null,
              brandId: null,
              brandInfo: null,
              featured: null,
              genderId: null,
              hasCouponCode: null,
              isNew: null,
              lensesFree: null,
              image: null,
              rate: null,
              isGlasses: null,
              shopId: null,
              shopInfo: null,
              typeProduct: null,
              photoInfo: null,
              isFavorite: null,
              shapeFaceInfo: [],
              colorInfo: [],
              sizeFaceInfo: [],
              shapeframeinfo: [],
              sizeModeInfo: []),
      quantity: this.quantity,
      price: this.price,
      APD: this.APD,
      created_at: this.created_at,
      IPD: this.IPD,
      LeftAXI: this.LeftAXI,
      LeftCYL: this.LeftCYL,
      LeftNear: this.LeftNear,
      LeftSPH: this.LeftSPH,
      order_id: this.order_id,
      product_id: this.product_id,
      RightAXI: this.RightAXI,
      RightCYL: this.RightCYL,
      RightNear: this.RightNear,
      RightSPH: this.RightSPH,
      type_product: this.type_product,
      updated_at: this.updated_at);
}
