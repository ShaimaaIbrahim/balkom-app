import 'base_entity.dart';

class ExtraGlassesItemEntity extends BaseEntity {
  final int? id;
  final String? name;
  final String? value;
  final String? image;

  ExtraGlassesItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.value,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'value': value,
        'image': image,
      };

  factory ExtraGlassesItemEntity.fromJson(Map<String, dynamic> json) =>
      ExtraGlassesItemEntity(
          id: json['id'],
          name: json['name'],
          image: json['image'],
          value: json['value']);

  @override
  List<Object> get props => [
        id ?? '',
        name ?? '',
        image ?? '',
        value ?? '',
      ];
}
