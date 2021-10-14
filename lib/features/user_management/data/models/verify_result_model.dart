// import 'package:ojos_app/core/models/base_model.dart';
// import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';
// import 'package:flutter/foundation.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'verify_result_model.g.dart';
//
// @JsonSerializable()
// class VerifyResultModel extends BaseModel<LoginResult> {
//   final int statusCode;
//   final String token;
//   // final ProfileModel profile;
//
//   VerifyResultModel({
//     @required this.statusCode,
//     @required this.token,
//     //@required this.profile,
//   });
//
//   factory VerifyResultModel.fromJson(Map<String, dynamic> json) =>
//       _$VerifyResultModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$VerifyResultModelToJson(this);
//
//   @override
//   LoginResult toEntity() => LoginResult(
//      //   profile: profile?.toEntity()??null,
//         token: token,
//         statusCode: statusCode,
//       );
// }
