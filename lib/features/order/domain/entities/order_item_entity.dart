import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';

class OrderItemEntity extends BaseEntity {
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
  final ProductEntity? product;

  OrderItemEntity({
    this.product,
    this.quantity,
    this.id,
    this.APD,
    this.created_at,
    this.IPD,
    this.LeftAXI,
    this.LeftCYL,
    this.LeftNear,
    this.price,
    this.LeftSPH,
    this.order_id,
    this.product_id,
    this.RightAXI,
    this.RightCYL,
    this.RightNear,
    this.RightSPH,
    this.type_product,
    this.updated_at,
    this.user_id,
  });

  @override
  List<Object> get props => [
        product ?? '',
        quantity ?? '',
        id ?? '',
        APD ?? '',
        created_at ?? '',
        IPD ?? '',
        LeftAXI ?? '',
        LeftCYL ?? '',
        LeftNear ?? '',
        price ?? '',
        LeftSPH ?? '',
        order_id ?? '',
        product_id ?? '',
        RightAXI ?? '',
        RightCYL ?? '',
        RightSPH ?? '',
        type_product ?? '',
        updated_at ?? '',
        user_id ?? '',
      ];
}
