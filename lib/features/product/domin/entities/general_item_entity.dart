import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class GeneralItemEntity extends BaseEntity {
  final int id;
  final String name;
  final String value;
  final String image;

  GeneralItemEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, image, value];
}
