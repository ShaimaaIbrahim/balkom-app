import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:ojos_app/features/product/data/models/item_model.dart';
import 'package:ojos_app/features/product/domin/entities/item_entity.dart';

import 'city_order_entity.dart';
import 'order_item_entity.dart';
import 'user_address_entity.dart';

class GeneralOrderItemEntity extends BaseEntity {
  final String? order_date;
  final int? id;
  final String? uid;
  final String? order_number;
  final int? user_id;
  final String? dest_name;
  final int? coupon_id;
  final int? tax;
  final int? subtotal;
  int? delivery_fee;
  int? discount;
  final int? paid_amount;
  final int? remaining_amount;
  final int? method_id;
  final String? method_name;
  final String? status;
  final int? city_id;
  final String? cityname;
  final int? neighborhood_id;
  final String? neighborhood;
  final String? description;
  final int? quantity_id;
  final String? quantity_name;
  final int? load_id;
  final String? load_product;
  final int? delivery_to;
  final String? deliveryto;
  final int? dest_type;
  final String? desttype;
  final String? destname;
  final String? guard_number;
   int? shipping_fee;
  final int? payment_id;
  final int? shipping_id;
  final String? note;
  final int? price_discount;
  double? orginal_price;
  final int? total;
  final String? delivery_address;
  final String? delivery_city;
  final String? delivery_state;
  final String? delivery_zipcode;
  final String? delivery_phone;
  final String? billing_name;
  final String? point_map;
  final String? statusint;
  final String? paymentmehtod;
  final String? orderimage;
  final ItemEntity? shippingcarrier;
  final UserAddressEntity? user_address;
  final CityOrderEntity? city;
  final List<OrderItemEntity>? order_items;

  GeneralOrderItemEntity({
    required this.order_date,
    required this.delivery_fee,
    required this.subtotal,
    required this.guard_number,
    required this.dest_name,
    required this.paid_amount,
    required this.remaining_amount,
    required this.method_id,
    required this.method_name,
    required this.city_id,
    required this.cityname,
    required this.neighborhood_id,
    required this.neighborhood,
    required this.description,
    required this.quantity_id,
    required this.quantity_name,
    required this.load_id,
    required this.load_product,
    required this.delivery_to,
    required this.deliveryto,
    required this.dest_type,
    required this.desttype,
    required this.destname,
    required this.id,
    required this.user_id,
    required this.total,
    required this.discount,
    required this.status,
    required this.city,
    required this.billing_name,
    required this.coupon_id,
    required this.delivery_address,
    required this.delivery_city,
    required this.delivery_phone,
    required this.delivery_state,
    required this.delivery_zipcode,
    required this.note,
    required this.order_items,
    required this.paymentmehtod,
    required this.order_number,
    required this.orginal_price,
    required this.payment_id,
    required this.point_map,
    required this.orderimage,
    required this.statusint,
    required this.price_discount,
    required this.shipping_fee,
    required this.shipping_id,
    required this.shippingcarrier,
    required this.tax,
    required this.uid,
    required this.user_address,
  });

  @override
  List<Object> get props => [
        id ?? '',
        user_id ?? '',
        total ?? '',
        discount ?? '',
        cityname ?? '',
        destname ?? '',
        desttype ?? '',
        deliveryto ?? '',
        delivery_city ?? '',
        delivery_address ?? '',
        delivery_state ?? '',
        status ?? '',
        city ?? '',
        billing_name ?? '',
        coupon_id ?? '',
        delivery_address ?? '',
        delivery_city ?? '',
        paymentmehtod ?? '',
        statusint ?? '',
        orderimage ?? '',
        delivery_phone ?? '',
        delivery_state ?? '',
        delivery_zipcode ?? '',
        note ?? '',
        order_items ?? '',
        order_number ?? '',
        orginal_price ?? '',
        payment_id ?? '',
        point_map ?? '',
        price_discount ?? '',
        shipping_fee ?? '',
        shipping_id ?? '',
        shippingcarrier ?? '',
        tax ?? '',
        uid ?? '',
        user_address ?? '',
      ];
}
