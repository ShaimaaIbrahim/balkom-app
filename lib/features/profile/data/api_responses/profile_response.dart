
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/cart/data/models/coupon_code_model.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/profile/data/models/profile_model.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends ApiResponse<ProfileModel> {
  ProfileResponse(
      bool status,
      String msg,
      ProfileModel result,
  ) : super(status, msg, result);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
