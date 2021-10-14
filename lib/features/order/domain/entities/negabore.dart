// To parse this JSON data, do
//
//     final neighbor = neighborFromJson(jsonString);

import 'dart:convert';

Neighbor neighborFromJson(String str) => Neighbor.fromJson(json.decode(str));

String neighborToJson(Neighbor data) => json.encode(data.toJson());

class Neighbor {
  Neighbor({
    this.status,
    this.msg,
    this.result,
  });

  bool? status;
  String? msg;
  List<Result>? result;

  factory Neighbor.fromJson(Map<String, dynamic> json) => Neighbor(
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
