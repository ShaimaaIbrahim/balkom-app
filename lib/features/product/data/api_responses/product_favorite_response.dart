import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/category_model.dart';
import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/product/data/models/product_favorite_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';

part 'product_favorite_response.g.dart';

@JsonSerializable()
class ProductFavoriteResponse extends ApiResponse<List<ProductFavoriteModel>> {
  ProductFavoriteResponse(
    bool status,
    String msg,
    List<ProductFavoriteModel> result,
  ) : super(status, msg, result);

  factory ProductFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductFavoriteResponseFromJson(json);
}
