// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResultModel _$RegisterResultModelFromJson(Map<String, dynamic> json) {
  return RegisterResultModel(
    phone: json['phone'] as String?,
    name: json['name'] as String?,
    id: json['id'] as int,
    apiToken: json['api_token'] as String?,
    balance: json['balance'] as String?,
    credit: json['credit'] as int?,
    debit: json['debit'] as int,
    deviceType: json['device_type'] as String?,
    mobileActive: json['mobile_active'] as String?,
    otpCode: json['otp_code'] as int?,
    photo: json['photo'] as String?,
  );
}

Map<String, dynamic> _$RegisterResultModelToJson(
        RegisterResultModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.phone,
      'api_token': instance.apiToken,
      'otp_code': instance.otpCode,
      'mobile_active': instance.mobileActive,
      'device_type': instance.deviceType,
      'photo': instance.photo,
      'id': instance.id,
      'credit': instance.credit,
      'debit': instance.debit,
      'balance': instance.balance,
    };
