// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) {
  return OfferModel(
    middleOneHome: (json['mid_1'] as List<dynamic>?)
        ?.map((e) => OfferItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    topHome: (json['top'] as List<dynamic>?)
        ?.map((e) => OfferItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    bottomOneHome: (json['bottom_1'] as List<dynamic>?)
        ?.map((e) => OfferItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    bottomTwoHome: (json['bottom_2'] as List<dynamic>?)
        ?.map((e) => OfferItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    middleTwoHome: (json['mid_2'] as List<dynamic>?)
        ?.map((e) => OfferItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'top': instance.topHome,
      'mid_1': instance.middleOneHome,
      'mid_2': instance.middleTwoHome,
      'bottom_1': instance.bottomOneHome,
      'bottom_2': instance.bottomTwoHome,
    };
