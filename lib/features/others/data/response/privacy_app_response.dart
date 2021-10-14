import 'package:ojos_app/core/responses/api_response.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/features/others/data/models/about_app_result_model.dart';
import 'package:ojos_app/features/others/data/models/privacy_app_result_model.dart';

part 'privacy_app_response.g.dart';

@JsonSerializable()
class PrivacyAppResponse extends ApiResponse<PrivacyAppResultModel> {
  PrivacyAppResponse(
      bool status,
      String msg,
      PrivacyAppResultModel result,
  ) : super(status, msg, result);

  factory PrivacyAppResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivacyAppResponseFromJson(json);
}
