// To parse this JSON data, do
//
//     final negaModel = negaModelFromJson(jsonString);

import 'dart:convert';

NegaModel negaModelFromJson(String str) => NegaModel.fromJson(json.decode(str));

String negaModelToJson(NegaModel data) => json.encode(data.toJson());

class NegaModel {
  NegaModel({
    required this.status,
    required this.msg,
    required this.result,
  });

  bool status;
  String msg;
  List<NegaItem> result;

  factory NegaModel.fromJson(Map<String, dynamic> json) => NegaModel(
        status: json["status"],
        msg: json["msg"],
        result: List<NegaItem>.from(
            json["result"].map((x) => NegaItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class NegaItem {
  NegaItem({
    required this.id,
    required this.cityId,
    required this.name,
  });

  int id;
  int cityId;
  String name;

  factory NegaItem.fromJson(Map<String, dynamic> json) => NegaItem(
        id: json["id"],
        cityId: json["city_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "name": name,
      };

  @override
  String toString() {
    return '$name';
  }
}
