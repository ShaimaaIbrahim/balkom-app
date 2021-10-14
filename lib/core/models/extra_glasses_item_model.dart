import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';

import 'base_model.dart';

part 'extra_glasses_item_model.g.dart';

@JsonSerializable()
class ExtraGlassesItemModel extends BaseModel<ExtraGlassesItemEntity> {
  final int id;
  final String name;
  final String value;
  final String image;

  ExtraGlassesItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.value,
  });

  factory ExtraGlassesItemModel.fromJson(Map<String, dynamic> json) =>
      _$ExtraGlassesItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraGlassesItemModelToJson(this);

  @override
  ExtraGlassesItemEntity toEntity() => ExtraGlassesItemEntity(
      id: this.id, name: this.name, image: this.image, value: this.value);
}
