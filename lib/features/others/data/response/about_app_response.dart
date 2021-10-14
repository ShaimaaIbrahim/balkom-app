import 'package:ojos_app/core/responses/api_response.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/features/others/data/models/about_app_result_model.dart';

part 'about_app_response.g.dart';

@JsonSerializable()
class AboutAppResponse extends ApiResponse<AboutAppResultModel> {
  AboutAppResponse(
      bool status,
      String msg,
    AboutAppResultModel result,
  ) : super(status, msg, result);

  factory AboutAppResponse.fromJson(Map<String, dynamic> json) =>
      _$AboutAppResponseFromJson(json);
}
