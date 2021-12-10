import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  final String? order_date;
  final int? user_address_id;
  final int? shipping_id;
  final int? city_id;
  final int? orginal_price;
  final int? discount;

  final int? tax;
  final int? shipping_fee;
  final int? total;
  final String? point_map;
  final String? note;

  final int? coupon_id;
  final String? couponcode;
  final CardOrderRequest? card;
  final DeliveryOrderRequest? delivery;
  final int? neighborhood_id;

  final int? load_id;
  final String? delivery_to;
  final String? dest_name;
  final String? guard_number;
  final int? dest_type;

  final int? subtotal;
  final int? delivery_fee;
  final List<ProductOrderRequest>? cartItems;
  final int? method_id;
  OrderRequest(
      {required this.order_date,
      required this.tax,
      required this.total,
      required this.shipping_fee,
      required this.orginal_price,
      required this.delivery_fee,
      required this.discount,
      required this.coupon_id,
      required this.subtotal,
      required this.note,
      required this.point_map,
      required this.city_id,
      required this.couponcode,
      required this.cartItems,
      required this.method_id,
      required this.user_address_id,
      required this.card,
      required this.delivery,
      required this.shipping_id,
      required this.neighborhood_id,
      required this.load_id,
      required this.delivery_to,
      required this.dest_name,
      required this.guard_number,
      required this.dest_type});

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}

@JsonSerializable()
class ProductOrderRequest {
  final int? product_id;
  final int? type_product;
  final int? Is_Glasses;
  // final int color_id;
  final int? brand_id;
  final int? quantity;
  final double? price;
  // final String lens_size;
//  final int sizeMode;
//  final String lens_right_size;
  // final String lens_left_size;

  ProductOrderRequest({
    @required this.price,
    @required this.type_product,
    @required this.product_id,
    //  @required this.lens_size,
    @required this.quantity,
    // @required this.sizeMode,
    @required this.brand_id,
    //   @required this.color_id,
    @required this.Is_Glasses,
    // @required this.lens_left_size,
    //  @required this.lens_right_size,
  });

  factory ProductOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOrderRequestToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return this.toJson().toString();
  }
}

@JsonSerializable()
class DeliveryOrderRequest {
  final String? delivery_name;
  final String? delivery_mobile_1;
  final String? delivery_mobile_2;
  final String? delivery_email;
  final String? delivery_address;
  final String? delivery_city;
  final String? delivery_state;
  final String? delivery_zipcode;
  final String? delivery_phone;

  DeliveryOrderRequest({
    @required this.delivery_address,
    @required this.delivery_city,
    @required this.delivery_phone,
    @required this.delivery_state,
    @required this.delivery_zipcode,
    @required this.delivery_email,
    @required this.delivery_mobile_1,
    @required this.delivery_mobile_2,
    @required this.delivery_name,
  });

  factory DeliveryOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOrderRequestToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return this.toJson().toString();
  }
}

@JsonSerializable()
class CardOrderRequest {
  final String? number;
  final String? exp_month;
  final String? exp_year;
  final String? cvc;

  CardOrderRequest({
    @required this.number,
    @required this.cvc,
    @required this.exp_month,
    @required this.exp_year,
  });
  @override
  String toString() {
    // TODO: implement toString
    return this.toJson().toString();
  }

  factory CardOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CardOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CardOrderRequestToJson(this);
}
