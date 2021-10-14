// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) =>
    OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  OrderDetails({
    required this.status,
    required this.msg,
    required this.result,
  });

  bool status;
  String msg;
  Result result;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        status: json["status"],
        msg: json["msg"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.couponId,
    required this.tax,
    required this.deliveryFee,
    required this.subtotal,
    required this.discount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.methodId,
    required this.mehtodName,
    required this.status,
    required this.cityId,
    required this.cityname,
    required this.neighborhoodId,
    required this.neighborhood,
    required this.description,
    required this.quantityId,
    required this.quantityName,
    required this.loadId,
    required this.loadProduct,
    required this.deliveryTo,
    required this.deliveryto,
    required this.destType,
    required this.desttype,
    required this.destName,
    required this.guardNumber,
    required this.orderItems,
  });

  int id;
  String uuid;
  int userId;
  dynamic couponId;
  int tax;
  int deliveryFee;
  int subtotal;
  int discount;
  int paidAmount;
  int remainingAmount;
  int methodId;
  String mehtodName;
  String status;
  int cityId;
  String cityname;
  int neighborhoodId;
  String neighborhood;
  String description;
  int quantityId;
  String quantityName;
  int loadId;
  String loadProduct;
  int deliveryTo;
  String deliveryto;
  dynamic destType;
  String desttype;
  dynamic destName;
  String guardNumber;
  List<OrderItem> orderItems;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        uuid: json["uuid"],
        userId: json["user_id"],
        couponId: json["coupon_id"],
        tax: json["tax"],
        deliveryFee: json["delivery_fee"],
        subtotal: json["subtotal"],
        discount: json["discount"],
        paidAmount: json["paid_amount"],
        remainingAmount: json["remaining_amount"],
        methodId: json["method_id"],
        mehtodName: json["mehtod_name"],
        status: json["status"],
        cityId: json["city_id"],
        cityname: json["cityname"],
        neighborhoodId: json["neighborhood_id"],
        neighborhood: json["neighborhood"],
        description: json["description"],
        quantityId: json["quantity_id"],
        quantityName: json["quantity_name"],
        loadId: json["load_id"],
        loadProduct: json["load_product"],
        deliveryTo: json["delivery_to"],
        deliveryto: json["deliveryto"],
        destType: json["dest_type"],
        desttype: json["desttype"],
        destName: json["dest_name"],
        guardNumber: json["guard_number"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "user_id": userId,
        "coupon_id": couponId,
        "tax": tax,
        "delivery_fee": deliveryFee,
        "subtotal": subtotal,
        "discount": discount,
        "paid_amount": paidAmount,
        "remaining_amount": remainingAmount,
        "method_id": methodId,
        "mehtod_name": mehtodName,
        "status": status,
        "city_id": cityId,
        "cityname": cityname,
        "neighborhood_id": neighborhoodId,
        "neighborhood": neighborhood,
        "description": description,
        "quantity_id": quantityId,
        "quantity_name": quantityName,
        "load_id": loadId,
        "load_product": loadProduct,
        "delivery_to": deliveryTo,
        "deliveryto": deliveryto,
        "dest_type": destType,
        "desttype": desttype,
        "dest_name": destName,
        "guard_number": guardNumber,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.discountType,
    required this.discountPrice,
    required this.image,
    required this.isNew,
    required this.description,
    required this.brandId,
    required this.rate,
    required this.isReview,
    required this.isFavorite,
    required this.reviewCount,
    required this.productReviews,
  });

  int orderId;
  int productId;
  int quantity;
  int price;
  String name;
  dynamic discountType;
  dynamic discountPrice;
  String image;
  bool isNew;
  String description;
  dynamic brandId;
  String rate;
  bool isReview;
  bool isFavorite;
  int reviewCount;
  List<dynamic> productReviews;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        name: json["name"],
        discountType: json["discount_type"],
        discountPrice: json["discount_price"],
        image: json["image"],
        isNew: json["is_new"],
        description: json["description"],
        brandId: json["brand_id"],
        rate: json["rate"],
        isReview: json["isReview"],
        isFavorite: json["isFavorite"],
        reviewCount: json["review_count"],
        productReviews:
            List<dynamic>.from(json["product_reviews"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "name": name,
        "discount_type": discountType,
        "discount_price": discountPrice,
        "image": image,
        "is_new": isNew,
        "description": description,
        "brand_id": brandId,
        "rate": rate,
        "isReview": isReview,
        "isFavorite": isFavorite,
        "review_count": reviewCount,
        "product_reviews": List<dynamic>.from(productReviews.map((x) => x)),
      };
}
