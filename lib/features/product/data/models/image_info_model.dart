import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/product/domin/entities/image_info_entity.dart';

part 'image_info_model.g.dart';

@JsonSerializable()
class ImageInfoModel extends BaseModel<ImageInfoEntity> {
  final int id;
  final String productId;
  final String image;

  ImageInfoModel({
    required this.id,
    required this.productId,
    required this.image,
  });

  factory ImageInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ImageInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageInfoModelToJson(this);

  @override
  ImageInfoEntity toEntity() => ImageInfoEntity(
      id: this.id, image: this.image, productId: this.productId);
}
