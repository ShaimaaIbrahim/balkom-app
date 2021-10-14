import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/cart/data/models/payment_method_model.dart';

part 'payment_method_response.g.dart';

@JsonSerializable()
class PaymentMethodsResponse extends ApiResponse<List<PaymentMethodModel>> {
  PaymentMethodsResponse(
    bool status,
    String msg,
    List<PaymentMethodModel> result,
  ) : super(status, msg, result);

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsResponseFromJson(json);
}
