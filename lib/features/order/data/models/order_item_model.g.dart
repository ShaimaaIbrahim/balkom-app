// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) {
  return OrderItemModel(
    product: json['product'] == null
        ? null
        : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    quantity: json['quantity'] as int?,
    id: json['id'] as int?,
    APD: json['APD'] as int?,
    created_at: json['created_at'] as String?,
    IPD: json['IPD'] as int?,
    LeftAXI: json['LeftAXI'] as int?,
    LeftCYL: json['LeftCYL'] as int?,
    LeftNear: json['LeftNear'] as int?,
    price: json['price'] as int?,
    LeftSPH: json['LeftSPH'] as int?,
    order_id: json['order_id'] as int?,
    product_id: json['product_id'] as int?,
    RightAXI: json['RightAXI'] as int?,
    RightCYL: json['RightCYL'] as int?,
    RightNear: json['RightNear'] as int?,
    RightSPH: json['RightSPH'] as int?,
    type_product: json['type_product'] as int?,
    updated_at: json['updated_at'] as String?,
    user_id: json['user_id'] as int?,
  );
}

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'order_id': instance.order_id,
      'product_id': instance.product_id,
      'type_product': instance.type_product,
      'quantity': instance.quantity,
      'price': instance.price,
      'RightSPH': instance.RightSPH,
      'RightCYL': instance.RightCYL,
      'RightAXI': instance.RightAXI,
      'RightNear': instance.RightNear,
      'LeftSPH': instance.LeftSPH,
      'LeftCYL': instance.LeftCYL,
      'LeftAXI': instance.LeftAXI,
      'LeftNear': instance.LeftNear,
      'APD': instance.APD,
      'IPD': instance.IPD,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'product': instance.product,
    };
