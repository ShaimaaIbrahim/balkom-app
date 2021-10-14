import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';

part 'city_order_model.g.dart';

@JsonSerializable()
class CityOrderModel extends BaseModel<CityOrderEntity> {
  final int? id;
  final String? name;
  final String? shiping_time;
  final bool? status;

  CityOrderModel({
    required this.id,
    required this.name,
    required this.shiping_time,
    required this.status,
  });

  factory CityOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CityOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityOrderModelToJson(this);

  @override
  CityOrderEntity toEntity() => CityOrderEntity(
      id: this.id,
      name: this.name,
      status: this.status,
      shiping_time: this.shiping_time);
}
