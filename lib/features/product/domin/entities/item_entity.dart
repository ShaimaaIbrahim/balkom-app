import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class ItemEntity extends BaseEntity {
  final int? id;
  final String? name;

  ItemEntity({
    this.id,
    this.name,
  });

  @override
  List<Object> get props => [
        id ?? '',
        name ?? '',
      ];
}
