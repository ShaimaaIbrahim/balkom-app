import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';

import '../entities/brand_entity.dart';

part 'brand_model.g.dart';

@JsonSerializable()
class BrandModel extends BaseModel<BrandEntity> {
  final int id;
  final String name;
  final String image;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
  });

  //
  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);

  @override
  BrandEntity toEntity() =>
      BrandEntity(id: this.id, name: this.name, image: this.image);
}
