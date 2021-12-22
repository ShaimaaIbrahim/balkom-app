

import 'package:ojos_app/features/order/domain/entities/order_item_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_info_item_entity.dart';

class OrderProductsArguments{
  final List<OrderItemEntity>? products;

  OrderProductsArguments({this.products});
}