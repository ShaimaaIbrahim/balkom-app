import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/user_management/data/models/login_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends ApiResponse<LoginResultModel> {
  // @JsonKey(name: 'access_token')
  // String accessToken;
  // @JsonKey(name: 'token_type')
  // String tokenType;
  // @JsonKey(name: 'expires_at')
  // String expiresAt;

  LoginResponse(
    bool status,
    String msg,
      LoginResultModel result,
    // this.accessToken,
    // this.expiresAt,
    // this.tokenType,
  ) : super(status, msg, result);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
