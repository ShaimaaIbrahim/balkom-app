import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/offer_item_entity.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/order/data/models/city_order_model.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/entities/order_item_entity.dart';
import 'package:ojos_app/features/order/domain/entities/user_address_entity.dart';
import 'package:ojos_app/features/product/data/models/item_model.dart';
import 'package:ojos_app/features/product/domin/entities/item_entity.dart';

import 'order_item_model.dart';
import 'user_address_model.dart';

part 'general_order_item_model.g.dart';

@JsonSerializable()
class GeneralOrderItemModel extends BaseModel<GeneralOrderItemEntity> {
  final int? id;
  final String? uid;
  final String? order_number;
  final String? order_date;
  final int? user_id;
  final int? coupon_id;
  final int? tax;
  final String? dest_name;
  final int? delivery_fee;
  final int? subtotal;
  final int? discount;
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
  final int? shipping_fee;
  final int? payment_id;
  final int? shipping_id;
  final String? note;
  final int? price_discount;
  final double? orginal_price;
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
  final ItemModel? shippingcarrier;
  final UserAddressModel? user_address;
  final CityOrderModel? city;
  final List<OrderItemModel>? order_items;
  GeneralOrderItemModel({
    required this.order_date,
    this.delivery_fee,
    this.subtotal,
    required this.dest_name,
    required this.paid_amount,
    required this.remaining_amount,
    this.method_id,
    this.method_name,
    this.city_id,
    required this.cityname,
    this.neighborhood_id,
    required this.neighborhood,
    this.description,
    this.quantity_id,
    this.quantity_name,
    this.load_id,
    this.load_product,
    this.delivery_to,
    required this.deliveryto,
    this.dest_type,
    required this.desttype,
    required this.destname,
    this.guard_number,
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

  factory GeneralOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralOrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralOrderItemModelToJson(this);

  @override
  GeneralOrderItemEntity toEntity() => GeneralOrderItemEntity(
        id: this.id,
        user_id: this.user_id,
        total: this.total,
        status: this.status,
        dest_name: this.dest_name,
        statusint: this.statusint,
        paymentmehtod: this.paymentmehtod,
        orderimage: this.orderimage,
        billing_name: this.billing_name,
        coupon_id: this.coupon_id,
        delivery_address: this.delivery_address,
        delivery_city: this.delivery_city,
        delivery_phone: this.delivery_phone,
        delivery_state: this.delivery_state,
        delivery_zipcode: this.delivery_zipcode,
        discount: this.discount,
        note: this.note,
        city: this.city != null
            ? this.city!.toEntity()
            : CityOrderEntity(
                id: null, name: null, shiping_time: null, status: null),
        order_items: this.order_items != null
            ? this.order_items!.map((t) => t.toEntity()).toList()
            : [],
        order_number: this.order_number,
        orginal_price: this.orginal_price,
        payment_id: this.payment_id,
        point_map: this.point_map,
        price_discount: this.price_discount,
        shipping_fee: this.shipping_fee,
        shipping_id: this.shipping_id,
        shippingcarrier: this.shippingcarrier != null
            ? this.shippingcarrier!.toEntity()
            : ItemEntity(id: null, name: null),
        tax: this.tax,
        uid: this.uid,
        user_address: this.user_address != null
            ? user_address!.toEntity()
            : UserAddressEntity(
                id: null,
                user_id: null,
                longitude: null,
                latitude: null,
                is_default: false,
                description: null,
                address: null),
        neighborhood: this.neighborhood,
        destname: this.destname,
        desttype: this.desttype,
        cityname: this.cityname,
        dest_type: this.dest_type,
        description: this.description,
        delivery_to: this.delivery_to,
        deliveryto: this.deliveryto,
        method_id: this.method_id,
        guard_number: this.guard_number,
        city_id: this.city_id,
        neighborhood_id: this.neighborhood_id,
        method_name: this.method_name,
        quantity_id: this.quantity_id,
        quantity_name: this.quantity_name,
        remaining_amount: this.remaining_amount,
        paid_amount: this.paid_amount,
        load_product: this.load_product,
        load_id: this.load_id,
        delivery_fee: this.delivery_fee,
        subtotal: this.subtotal,
        order_date: this.order_date,
      );
}
