import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class UserAddressEntity extends BaseEntity {
  final int? id;
  final String? description;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool? is_default;
  final int? user_id;

  UserAddressEntity({
    this.id,
    this.user_id,
    this.address,
    this.longitude,
    this.latitude,
    this.description,
    this.is_default,
  });

  @override
  List<Object> get props => [
        id ?? '',
        user_id ?? '',
        address ?? '',
        longitude ?? '',
        latitude ?? '',
        description ?? '',
        is_default ?? '',
      ];
}
