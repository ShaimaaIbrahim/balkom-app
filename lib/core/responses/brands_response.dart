import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/brand_model.dart';
import 'package:ojos_app/core/responses/api_response.dart';

part 'brands_response.g.dart';

@JsonSerializable()
class BrandsResponse extends ApiResponse<List<BrandModel>> {
  BrandsResponse(
    bool status,
    String msg,
    List<BrandModel> result,
  ) : super(status, msg, result);

  factory BrandsResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandsResponseFromJson(json);
}
