import 'package:ojos_app/core/responses/api_response.dart';
import 'package:ojos_app/features/user_management/data/models/login_result_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/features/user_management/data/models/register_result_model.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse extends ApiResponse<RegisterResultModel> {

  RegisterResponse(
    bool status,
    String msg,
      RegisterResultModel result,
  ) : super(status, msg, result);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
