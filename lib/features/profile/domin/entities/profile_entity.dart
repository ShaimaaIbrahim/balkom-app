import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class ProfileEntity extends BaseEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? photo;
  final String? mobile;
  final String? address;
  final String? phone;
  final String? aboutMe;
  final bool? notify_new_product;
  final bool? notify_wallet;
  final bool? notify_offer;
  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.aboutMe,
    required this.photo,
    required this.phone,
    required this.notify_new_product,
    required this.notify_wallet,
    required this.notify_offer,
  });

  @override
  List<Object> get props => [
        id ?? '',
        name ?? '',
        email ?? '',
        mobile ?? '',
        address ?? '',
        aboutMe ?? '',
        photo ?? '',
        phone ?? '',
        notify_new_product ?? '',
        notify_wallet ?? '',
        notify_offer ?? '',
      ];
}
