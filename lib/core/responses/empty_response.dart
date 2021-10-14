import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/responses/api_response.dart';

import 'api_response.dart';

part 'empty_response.g.dart';

@JsonSerializable()
class EmptyResponse extends ApiResponse<Object> {
  EmptyResponse(bool status, String msg, Object result)
      : super(status, msg, result);

  factory EmptyResponse.fromJson(Map<String, dynamic> json) =>
      _$EmptyResponseFromJson(json);
}
