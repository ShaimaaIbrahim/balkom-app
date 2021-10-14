// To parse this JSON data, do
//
//     final negaM = negaMFromJson(jsonString);

import 'dart:convert';

NegaM negaMFromJson(String str) => NegaM.fromJson(json.decode(str));

String negaMToJson(NegaM data) => json.encode(data.toJson());

class NegaM {
  NegaM({
    this.status,
    this.msg,
    this.result,
  });

  bool? status;
  String? msg;
  List<Result>? result;

  factory NegaM.fromJson(Map<String, dynamic> json) => NegaM(
        status: json["status"],
        msg: json["msg"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.cityId,
    this.name,
  });

  int? id;
  int? cityId;
  String? name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        cityId: json["city_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "name": name,
      };
}
