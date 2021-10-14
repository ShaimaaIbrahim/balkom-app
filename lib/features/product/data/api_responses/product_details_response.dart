
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';

part 'product_details_response.g.dart';

@JsonSerializable()
class ProductDetailsResponse extends ApiResponse<ProductDetailsModel> {
  ProductDetailsResponse(
      bool status,
      String msg,
      ProductDetailsModel result,
  ) : super(status, msg, result);

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);
}
