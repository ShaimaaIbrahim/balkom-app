import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/models/extra_glasses_item_model.dart';

import 'base_model.dart';

part 'extra_glasses_model.g.dart';

@JsonSerializable()
class ExtraGlassesModel extends BaseModel<ExtraGlassesEntity> {
  @JsonKey(name: 'lenseType')
  final List<ExtraGlassesItemModel>? lensesType;
  @JsonKey(name: 'Gender')
  final List<ExtraGlassesItemModel>? gender;
  @JsonKey(name: 'FrameShape')
  final List<ExtraGlassesItemModel>? frameShape;
  @JsonKey(name: 'Colors')
  final List<ExtraGlassesItemModel>? colors;
  @JsonKey(name: 'SizeFace')
  final List<ExtraGlassesItemModel>? sizeFace;
  @JsonKey(name: 'ShapeFace')
  final List<ExtraGlassesItemModel>? shapeFace;
  @JsonKey(name: 'SizeMode')
  final List<ExtraGlassesItemModel>? sizeMode;

  ExtraGlassesModel(
      {required this.colors,
      required this.frameShape,
      required this.gender,
      required this.lensesType,
      required this.shapeFace,
      required this.sizeMode,
      required this.sizeFace});

  factory ExtraGlassesModel.fromJson(Map<String, dynamic> json) =>
      _$ExtraGlassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraGlassesModelToJson(this);

  @override
  ExtraGlassesEntity toEntity() => ExtraGlassesEntity(
        colors: this.colors != null
            ? this.colors?.map((t) => t.toEntity()).toList()
            : [],
        frameShape: this.frameShape != null
            ? this.frameShape?.map((t) => t.toEntity()).toList()
            : [],
        gender: this.gender != null
            ? this.gender?.map((t) => t.toEntity()).toList()
            : [],
        lensesType: this.lensesType != null
            ? this.lensesType?.map((t) => t.toEntity()).toList()
            : [],
        shapeFace: this.shapeFace != null
            ? this.shapeFace?.map((t) => t.toEntity()).toList()
            : [],
        sizeMode: this.sizeMode != null
            ? this.sizeMode?.map((t) => t.toEntity()).toList()
            : [],
        sizeFace: this.sizeFace != null
            ? this.sizeFace?.map((t) => t.toEntity()).toList()
            : [],
      );
}
