import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/order/domain/entities/user_address_entity.dart';

part 'user_address_model.g.dart';

@JsonSerializable()
class UserAddressModel extends BaseModel<UserAddressEntity> {
  final int id;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final bool is_default;
  final int user_id;

  UserAddressModel({
    required this.id,
    required this.user_id,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.description,
    required this.is_default,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressModelToJson(this);

  @override
  UserAddressEntity toEntity() => UserAddressEntity(
      id: this.id,
      address: this.address,
      description: this.description,
      is_default: this.is_default,
      latitude: this.latitude,
      longitude: this.longitude,
      user_id: this.user_id);
}
