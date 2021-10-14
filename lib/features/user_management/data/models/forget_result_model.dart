import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/user_management/domain/entities/forget_result.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/user_management/domain/entities/forget_result.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';

part 'forget_result_model.g.dart';

@JsonSerializable()
class ForgetResultModel extends BaseModel<ForgetResult> {
  final String otp_code;

  // final String msg;

  ForgetResultModel({
    required this.otp_code,
  });

  factory ForgetResultModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetResultModelToJson(this);

  @override
  ForgetResult toEntity() => ForgetResult(
        otp_code: this.otp_code,
      );
}
