// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddressModel _$UserAddressModelFromJson(Map<String, dynamic> json) {
  return UserAddressModel(
    id: json['id'] as int,
    user_id: json['user_id'] as int,
    address: json['address'] as String,
    longitude: (json['longitude'] as num).toDouble(),
    latitude: (json['latitude'] as num).toDouble(),
    description: json['description'] as String,
    is_default: json['is_default'] as bool,
  );
}

Map<String, dynamic> _$UserAddressModelToJson(UserAddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_default': instance.is_default,
      'user_id': instance.user_id,
    };
