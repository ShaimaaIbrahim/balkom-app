import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/offer_item_entity.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/order/data/models/city_order_model.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
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
  final int? user_id;
  final int? payment_id;
  final int? coupon_id;
  final int? shipping_id;
  final int? shipping_fee;
  final String? note;
  final int? price_discount;
  final double? orginal_price;
  final int? tax;
  final int? discount;
  final int? total;
  final String? paymentmehtod;
  final String? delivery_address;
  final String? delivery_city;
  final String? delivery_state;
  final String? delivery_zipcode;
  final String? delivery_phone;
  final String? billing_name;
  final String? point_map;
  final String? status;
  final String? statusint;
  final String? orderimage;
  final ItemModel? shippingcarrier;
  final UserAddressModel? user_address;
  final List<OrderItemModel>? order_items;
  final CityOrderModel? city;
  GeneralOrderItemModel({
    required this.id,
    required this.user_id,
    required this.total,
    required this.discount,
    required this.status,
    required this.city,
    required this.orderimage,
    required this.statusint,
    required this.billing_name,
    required this.coupon_id,
    required this.delivery_address,
    required this.delivery_city,
    required this.delivery_phone,
    required this.delivery_state,
    required this.paymentmehtod,
    required this.delivery_zipcode,
    required this.note,
    required this.order_items,
    required this.order_number,
    required this.orginal_price,
    required this.payment_id,
    required this.point_map,
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
              address: null));
}
