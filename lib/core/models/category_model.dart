import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/models/base_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends BaseModel<CategoryEntity> {
  final int id;
  final String name;
  final String image;
  final String? description;
  final String? status;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      this.status,
      this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  CategoryEntity toEntity() => CategoryEntity(
      id: this.id,
      name: this.name,
      image: this.image,
      status: this.status,
      description: this.description);
}
