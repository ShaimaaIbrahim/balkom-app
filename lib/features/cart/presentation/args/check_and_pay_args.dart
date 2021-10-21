import 'package:flutter/cupertino.dart';
import 'package:ojos_app/features/product/domin/entities/cart_entity.dart';

class CheckAndPayArgs {
  final String? totalPrice;
  final int? shipping_id;
  final int? city_id;
  final int? orginal_price;
  final int? price_discount;
  final int? tax;
  final int? shipping_fee;
  final double? total;
  final String? note;
  final String? point_map;
  final int? coupon_id;
  final int? paymentMethods;
  final String? couponcode;
  final List<CartEntity>? listOfOrder;
  final int? neighborhood_id;
  final int? load_id;
  final String? delivery_to;
  final String? dest_name;
  final String? guard_number;
  final int? dest_type;
  final int? subtotal;
  final int? delivery_fee;
  final int? discount;
  final int? shipping_time;
  const CheckAndPayArgs(
      {required this.listOfOrder,
      this.totalPrice,
      this.discount,
      this.shipping_time,
      this.couponcode,
      this.delivery_fee,
      this.city_id,
      this.shipping_id,
      this.paymentMethods,
      this.point_map,
      this.subtotal,
      this.note,
      this.coupon_id,
      this.orginal_price,
      this.shipping_fee,
      this.price_discount,
      this.total,
      this.tax,
      this.neighborhood_id,
      this.load_id,
      this.delivery_to,
      this.dest_name,
      this.guard_number,
      this.dest_type});
}
