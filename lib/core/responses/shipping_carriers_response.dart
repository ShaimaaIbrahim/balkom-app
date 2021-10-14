import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/shipping_carriers_model.dart';
import 'package:ojos_app/core/responses/api_response.dart';

part 'shipping_carriers_response.g.dart';

@JsonSerializable()
class ShippingCarriersResponse
    extends ApiResponse<List<ShippingCarriersModel>> {
  ShippingCarriersResponse(
    bool status,
    String msg,
    List<ShippingCarriersModel> result,
  ) : super(status, msg, result);

  factory ShippingCarriersResponse.fromJson(Map<String, dynamic> json) =>
      _$ShippingCarriersResponseFromJson(json);
}
