// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferResponse _$OfferResponseFromJson(Map<String, dynamic> json) {
  return OfferResponse(
    json['status'] as bool,
    json['msg'] as String,
    OfferModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OfferResponseToJson(OfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
