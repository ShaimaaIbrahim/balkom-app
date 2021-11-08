// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultModel _$LoginResultModelFromJson(Map<String, dynamic> json) {
  return LoginResultModel(
    phone: json['phone'] as String,
    name: json['name'] as String,
    id: json['id'] as int,
    tokenType: json['token_type'] as String,
    balance: json['balance'].toString(),
    credit: json['credit'],
    debit: json['debit'],
    expiresAt: json['expires_at'] as String,
    otpCode: json['otp_code'] as int,
    photo: json['photo'] as String,
    status: json['status'],
    aboutMe: json['about_me'] as String,
    address: json['address'] as String,
    accessToken: json['access_token'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$LoginResultModelToJson(LoginResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photo': instance.photo,
      'status': instance.status,
      'phone': instance.phone,
      'otp_code': instance.otpCode,
      'address': instance.address,
      'about_me': instance.aboutMe,
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_at': instance.expiresAt,
      'credit': instance.credit,
      'debit': instance.debit,
      'balance': instance.balance,
    };
