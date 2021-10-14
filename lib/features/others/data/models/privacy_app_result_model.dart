import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';
import 'package:ojos_app/features/others/domain/entity/privacy_result.dart';

part 'privacy_app_result_model.g.dart';

@JsonSerializable()
class PrivacyAppResultModel extends BaseModel<PrivacyAppResult> {
  final String title;
  final String details;

  PrivacyAppResultModel({
    required this.details,
    required this.title,
  });

  Map<String, dynamic> toJson() => _$PrivacyAppResultModelToJson(this);

  factory PrivacyAppResultModel.fromJson(Map<String, dynamic> json) =>
      _$PrivacyAppResultModelFromJson(json);


  @override
  PrivacyAppResult toEntity() {
    return PrivacyAppResult(
      details:  this.details,
      title: this.title,
    );
  }
}
