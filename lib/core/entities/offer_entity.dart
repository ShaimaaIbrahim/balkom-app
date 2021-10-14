import 'package:ojos_app/core/entities/offer_item_entity.dart';

import 'base_entity.dart';

class OfferEntity extends BaseEntity {
  final List<OfferItemEntity> topHome;

  final List<OfferItemEntity> middleOneHome;

  final List<OfferItemEntity> middleTwoHome;

  final List<OfferItemEntity> bottomOneHome;

  final List<OfferItemEntity> bottomTwoHome;

  OfferEntity({
    required this.middleOneHome,
    required this.topHome,
    required this.middleTwoHome,
    required this.bottomTwoHome,
    required this.bottomOneHome,
  });

  @override
  List<Object> get props =>
      [topHome, middleOneHome, middleTwoHome, bottomTwoHome, bottomOneHome];
}
