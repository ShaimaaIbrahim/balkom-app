import 'base_entity.dart';
import 'extra_glasses_item_entity.dart';

class ExtraGlassesEntity extends BaseEntity {
  final List<ExtraGlassesItemEntity>? lensesType;
  final List<ExtraGlassesItemEntity>? gender;
  final List<ExtraGlassesItemEntity>? frameShape;
  final List<ExtraGlassesItemEntity>? colors;
  final List<ExtraGlassesItemEntity>? sizeFace;
  final List<ExtraGlassesItemEntity>? shapeFace;
  final List<ExtraGlassesItemEntity>? sizeMode;

  ExtraGlassesEntity(
      {required this.colors,
      required this.frameShape,
      required this.gender,
      required this.lensesType,
      required this.shapeFace,
      required this.sizeMode,
      required this.sizeFace});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'colors': colors?.map((leave) => leave.toJson()).toList(),
        'frameShape': frameShape?.map((leave) => leave.toJson()).toList(),
        'gender': gender?.map((leave) => leave.toJson()).toList(),
        'lensesType': lensesType?.map((leave) => leave.toJson()).toList(),
        'shapeFace': shapeFace?.map((leave) => leave.toJson()).toList(),
        'sizeMode': sizeMode?.map((leave) => leave.toJson()).toList(),
        'sizeFace': sizeFace?.map((leave) => leave.toJson()).toList(),
      };

  factory ExtraGlassesEntity.fromJson(Map<String, dynamic> json) =>
      ExtraGlassesEntity(
          colors: (json['colors'] as List)
              .map((e) =>
                  ExtraGlassesItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
          frameShape: (json['frameShape'] as List)
              .map((e) =>
                  ExtraGlassesItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
          gender: (json['gender'] as List)
              .map((e) =>
                  ExtraGlassesItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
          lensesType: (json['lensesType'] as List)
              .map((e) =>
                  ExtraGlassesItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
          sizeMode: (json['sizeMode'] as List)
              .map((e) => ExtraGlassesItemEntity.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          sizeFace: (json['sizeFace'] as List)
              .map((e) =>
                  ExtraGlassesItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
          shapeFace: (json['shapeFace'] as List)
              .map((e) =>
                  ExtraGlassesItemEntity.fromJson(e as Map<String, dynamic>))
              .toList());

  @override
  List<Object> get props => [
        colors ?? 'colors null',
        frameShape ?? 'frameShape null',
        gender ?? 'gender null',
        lensesType ?? 'lensesType null',
        shapeFace ?? 'shapeFace null',
        sizeMode ?? 'sizeMode null',
        sizeFace ?? 'sizeFace null',
      ];
}
