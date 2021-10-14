import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

class BannerEntity extends BaseEntity {
  final int id;
  final String url;
  final String imageUrl;

  BannerEntity({required this.id, required this.imageUrl, required this.url});

  @override
  List<Object> get props => [id, url, imageUrl];
}
