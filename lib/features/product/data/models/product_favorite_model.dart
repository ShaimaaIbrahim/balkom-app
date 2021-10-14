import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/product/data/models/general_item_model.dart';
import 'package:ojos_app/features/product/data/models/image_info_model.dart';
import 'package:ojos_app/features/product/data/models/item_model.dart';
import 'package:ojos_app/features/product/data/models/product_info_item_model.dart';
import 'package:ojos_app/features/product/domin/entities/general_item_entity.dart';
import 'package:ojos_app/features/product/domin/entities/item_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_info_item_entity.dart';

import 'product_model.dart';

part 'product_favorite_model.g.dart';

@JsonSerializable()
class ProductFavoriteModel extends BaseModel<ProductFavoriteEntity> {
  @JsonKey(name: 'product')
  final ProductModel? product;

  ProductFavoriteModel({
    this.product,
  });

  factory ProductFavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFavoriteModelToJson(this);

  @override
  ProductFavoriteEntity toEntity() => ProductFavoriteEntity(
        product: this.product! != null
            ? this.product!.toEntity()
            : ProductFavoriteModel(product: null) as ProductEntity,
      );
}
