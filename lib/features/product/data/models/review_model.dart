import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/product/domin/entities/review_entity.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends BaseModel<ReviewEntity> {
  final int? id;
  final String? review;
  final String? rate;
  final int? userId;
  final String? userName;
  final String? userImage;
  final String? userAddress;

  ReviewModel({
    required this.id,
    required this.rate,
    required this.userName,
    required this.review,
    required this.userId,
    required this.userAddress,
    required this.userImage,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  @override
  ReviewEntity toEntity() => ReviewEntity(
      id: this.id,
      userName: this.userName,
      rate: this.rate,
      review: this.review,
      userAddress: this.userAddress,
      userId: this.userId,
      userImage: this.userImage);
}
