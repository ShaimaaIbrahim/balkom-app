
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/cart/data/models/coupon_code_model.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';

part 'coupon_code_response.g.dart';

@JsonSerializable()
class CouponCodeResponse extends ApiResponse<CouponCodeModel> {
  CouponCodeResponse(
      bool status,
      String msg,
      CouponCodeModel result,
  ) : super(status, msg, result);

  factory CouponCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeResponseFromJson(json);
}
