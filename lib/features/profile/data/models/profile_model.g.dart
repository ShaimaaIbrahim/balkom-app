// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] ?? '',
    mobile: json['mobile'] ?? '',
    address: json['address'] as String,
    aboutMe: json['about_me'] as String,
    photo: json['photo'] as String,
    phone: json['phone'] as String,
    notify_new_product: json['notify_new_product'] ?? false,
    notify_offer: json['notify_offer'] ?? false,
    notify_wallet: json['notify_wallet'] ?? false,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photo': instance.photo,
      'mobile': instance.mobile,
      'address': instance.address,
      'phone': instance.phone,
      'about_me': instance.aboutMe,
      'notify_new_product': instance.notify_new_product,
      'notify_wallet': instance.notify_wallet,
      'notify_offer': instance.notify_offer,
    };
