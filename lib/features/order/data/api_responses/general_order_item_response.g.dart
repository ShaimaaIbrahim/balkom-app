// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_order_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralOrderItemResponse _$GeneralOrderItemResponseFromJson(
    Map<String, dynamic> json) {
  return GeneralOrderItemResponse(
    json['status'] as bool,
    json['msg'] as String,
    (json['result'] as List)
        .map((e) =>
            e = GeneralOrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GeneralOrderItemResponseToJson(
        GeneralOrderItemResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'result': instance.result,
    };
