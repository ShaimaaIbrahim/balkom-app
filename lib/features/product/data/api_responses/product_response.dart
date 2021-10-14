import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/category_model.dart';
import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse extends ApiResponse<List<ProductModel>> {
  ProductResponse(
    bool status,
    String msg,
    List<ProductModel> result,
  ) : super(status, msg, result);

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
}
