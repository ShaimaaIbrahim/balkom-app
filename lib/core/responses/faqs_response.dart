import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/brand_model.dart';
import 'package:ojos_app/core/models/faqs_model.dart';
import 'package:ojos_app/core/models/notifications_model.dart';
import 'package:ojos_app/core/responses/api_response.dart';

part 'faqs_response.g.dart';

@JsonSerializable()
class FaqsResponse extends ApiResponse<List<FaqsModel>> {
  FaqsResponse(
    bool status,
    String msg,
    List<FaqsModel> result,
  ) : super(status, msg, result);
  //
  factory FaqsResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqsResponseFromJson(json);
}
