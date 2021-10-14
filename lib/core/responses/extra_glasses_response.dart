import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/extra_glasses_model.dart';

import 'api_response.dart';

part 'extra_glasses_response.g.dart';

@JsonSerializable()
class ExtraGlassesResponse extends ApiResponse<ExtraGlassesModel> {
  ExtraGlassesResponse(
    bool status,
    String msg,
    ExtraGlassesModel result,
  ) : super(status, msg, result);

  factory ExtraGlassesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtraGlassesResponseFromJson(json);
}
