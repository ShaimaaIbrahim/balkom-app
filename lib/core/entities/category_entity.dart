import 'package:ojos_app/core/entities/base_entity.dart';

class CategoryEntity extends BaseEntity {
  final int id;
  final String? name;
  final String? image;
  final String? description;
  final String? status;

  CategoryEntity(
      {required this.id,
      required this.name,
      required this.image,
      this.status,
      this.description});

  @override
  List<Object> get props => [
        id,
        name ?? '',
        image ?? '',
        status ?? 'status null',
        description ?? 'description null'
      ];
}
