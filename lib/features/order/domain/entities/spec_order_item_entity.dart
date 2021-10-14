import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:ojos_app/features/product/domin/entities/item_entity.dart';

import 'order_item_entity.dart';
import 'user_address_entity.dart';

class SpecOrderItemEntity extends BaseEntity {
  final int? id;
  final String? uid;
  final String? order_number;
  final int? user_id;
  final int? payment_id;
  final int? coupon_id;
  final int? shipping_id;
  final int? shipping_fee;
  final String? note;
  final int? price_discount;
  final int? orginal_price;
  final int? tax;
  final int? discount;
  final int? total;
  final String? delivery_address;
  final String? delivery_city;
  final String? delivery_state;
  final String? delivery_zipcode;
  final String? delivery_phone;
  final String? billing_name;
  final String? point_map;
  final String? status;
  final int? statusint;
  final String? orderimage;
  final ItemEntity? shippingcarrier;
  final UserAddressEntity? user_address;
  final OrderItemEntity? order_items;

  SpecOrderItemEntity({
    this.id,
    this.user_id,
    this.total,
    this.discount,
    this.status,
    this.statusint,
    this.orderimage,
    this.billing_name,
    this.coupon_id,
    this.delivery_address,
    this.delivery_city,
    this.delivery_phone,
    this.delivery_state,
    this.delivery_zipcode,
    this.note,
    this.order_items,
    this.order_number,
    this.orginal_price,
    this.payment_id,
    this.point_map,
    this.price_discount,
    this.shipping_fee,
    this.shipping_id,
    this.shippingcarrier,
    this.tax,
    this.uid,
    this.user_address,
  });

  @override
  List<Object> get props => [
        id!,
        user_id!,
        total!,
        discount!,
        status!,
        billing_name!,
        coupon_id!,
        delivery_address!,
        delivery_city!,
        delivery_phone!,
        delivery_state!,
        delivery_zipcode!,
        note!,
        statusint!,
        orderimage!,
        order_items!,
        order_number!,
        orginal_price!,
        payment_id!,
        point_map!,
        price_discount!,
        shipping_fee!,
        shipping_id!,
        shippingcarrier!,
        tax!,
        uid!,
        user_address!,
      ];
}
