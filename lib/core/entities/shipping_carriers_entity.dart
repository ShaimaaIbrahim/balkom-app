import 'package:ojos_app/core/entities/base_entity.dart';

class ShippingCarriersEntity extends BaseEntity {
  final int? id;
  final String? name;

  ShippingCarriersEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id ?? 'id is null', name ?? ''];
}
