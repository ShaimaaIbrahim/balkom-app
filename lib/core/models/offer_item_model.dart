import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/offer_item_entity.dart';

import 'base_model.dart';

part 'offer_item_model.g.dart';

@JsonSerializable()
class OfferItemModel extends BaseModel<OfferItemEntity> {
  final int? id;
  final String? name;
  final String? image;
  final String? info;
  @JsonKey(name: 'discount_price')
  final int? discountPrice;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'discount_type_ int? ')
  final int? discountTypeInt;
  @JsonKey(name: 'product_id')
  final int? productId;
  final String? type;
  final bool? is_glasses;

  OfferItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.is_glasses,
    required this.discountPrice,
    required this.discountType,
    required this.discountTypeInt,
    required this.info,
    required this.productId,
  });

  factory OfferItemModel.fromJson(Map<String, dynamic> json) =>
      _$OfferItemModelFromJson(json);

  Map<String?, dynamic> toJson() => _$OfferItemModelToJson(this);

  @override
  OfferItemEntity toEntity() => OfferItemEntity(
      id: this.id,
      name: this.name,
      image: this.image,
      type: this.type,
      is_glasses: this.is_glasses,
      discountPrice: this.discountPrice,
      discountTypeInt: this.discountTypeInt,
      discountType: this.discountType,
      info: this.info,
      productId: this.productId);
}
