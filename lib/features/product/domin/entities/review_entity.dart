import 'package:ojos_app/core/entities/base_entity.dart';

class ReviewEntity extends BaseEntity {
  final int? id;
  final String? review;
  final String? rate;
  final int? userId;
  final String? userName;
  final String? userImage;
  final String? userAddress;

  ReviewEntity({
    required this.id,
    required this.rate,
    required this.userName,
    required this.review,
    required this.userId,
    required this.userAddress,
    required this.userImage,
  });

  @override
  List<Object> get props => [
        id ?? '',
        rate ?? '',
        userName ?? '',
        review ?? '',
        userId ?? '',
        userAddress ?? '',
        userImage ?? '',
      ];
}
