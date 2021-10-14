import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/user_management/data/models/forget_result_model.dart';
import 'package:ojos_app/features/user_management/data/models/login_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_response.g.dart';

@JsonSerializable()
class ForgetResponse extends ApiResponse<ForgetResultModel> {
  // @JsonKey(name: 'access_token')
  // String accessToken;
  // @JsonKey(name: 'token_type')
  // String tokenType;
  // @JsonKey(name: 'expires_at')
  // String expiresAt;

  ForgetResponse(
    bool status,
    String msg,
      ForgetResultModel result,
    // this.accessToken,
    // this.expiresAt,
    // this.tokenType,
  ) : super(status, msg, result);

  factory ForgetResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetResponseFromJson(json);
}
