import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/models/offer_item_model.dart';

import 'base_model.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel extends BaseModel<OfferEntity> {
  @JsonKey(name: 'top')
  final List<OfferItemModel>? topHome;
  @JsonKey(name: 'mid_1')
  final List<OfferItemModel>? middleOneHome;
  @JsonKey(name: 'mid_2')
  final List<OfferItemModel>? middleTwoHome;
  @JsonKey(name: 'bottom_1')
  final List<OfferItemModel>? bottomOneHome;
  @JsonKey(name: 'bottom_2')
  final List<OfferItemModel>? bottomTwoHome;

  OfferModel({
    required this.middleOneHome,
    required this.topHome,
    required this.bottomOneHome,
    required this.bottomTwoHome,
    required this.middleTwoHome,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);

  @override
  OfferEntity toEntity() => OfferEntity(
        middleOneHome: this.middleOneHome != null
            ? this.middleOneHome!.map((t) => t.toEntity()).toList()
            : [],
        topHome: this.topHome != null
            ? this.topHome!.map((t) => t.toEntity()).toList()
            : [],
        bottomOneHome: this.bottomOneHome != null
            ? this.bottomOneHome!.map((t) => t.toEntity()).toList()
            : [],
        bottomTwoHome: this.bottomTwoHome != null
            ? this.bottomTwoHome!.map((t) => t.toEntity()).toList()
            : [],
        middleTwoHome: this.middleTwoHome != null
            ? this.middleTwoHome!.map((t) => t.toEntity()).toList()
            : [],
      );
}
