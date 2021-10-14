// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return ReviewModel(
    id: json['id'] as int?,
    rate: json['rate'] as String?,
    userName: json['userName'] as String?,
    review: json['review'] as String?,
    userId: json['userId'] as int?,
    userAddress: json['userAddress'] as String?,
    userImage: json['userImage'] as String?,
  );
}

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'review': instance.review,
      'rate': instance.rate,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'userAddress': instance.userAddress,
    };
