import 'package:ojos_app/core/entities/base_entity.dart';

class BrandEntity extends BaseEntity {
  final int id;
  final String name;
  final String image;

  BrandEntity({required this.id, required this.name, required this.image});

  @override
  List<Object> get props => [
        id,
        name,
        image,
      ];
}
