import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

import 'general_item_entity.dart';
import 'image_info_entity.dart';
import 'item_entity.dart';
import 'product_entity.dart';
import 'product_info_item_entity.dart';

class ProductFavoriteEntity extends BaseEntity {
  final ProductEntity? product;

  ProductFavoriteEntity({
    this.product,
  });

  @override
  List<Object> get props => [product!];
}
