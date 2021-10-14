// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityOrderModel _$CityOrderModelFromJson(Map<String, dynamic> json) {
  return CityOrderModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    shiping_time: json['shiping_time'] as String?,
    status: json['status'] as bool?,
  );
}

Map<String, dynamic> _$CityOrderModelToJson(CityOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shiping_time': instance.shiping_time,
      'status': instance.status,
    };
