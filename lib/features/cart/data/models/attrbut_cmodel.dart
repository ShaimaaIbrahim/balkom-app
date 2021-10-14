// To parse this JSON data, do
//
//     final attrbuotmodel = attrbuotmodelFromJson(jsonString);

import 'dart:convert';

Attrbuotmodel attrbuotmodelFromJson(String str) => Attrbuotmodel.fromJson(json.decode(str));

String attrbuotmodelToJson(Attrbuotmodel data) => json.encode(data.toJson());

class Attrbuotmodel {
  Attrbuotmodel({
    this.status,
    this.msg,
    this.result,
  });

  bool? status;
  String? msg;
  Result? result;

  factory Attrbuotmodel.fromJson(Map<String, dynamic> json) => Attrbuotmodel(
    status: json["status"],
    msg: json["msg"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "result": result!.toJson(),
  };
}

class Result {
  Result({
     this.quantitylist,
     this.deliveryto,
    this.loadproduct,
    this.desttype,
  });

  List<Deliveryto>? quantitylist;
  List<Deliveryto>? deliveryto;
  List<Deliveryto>? loadproduct;
  List<Deliveryto>? desttype;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    quantitylist: List<Deliveryto>.from(json["quantitylist"].map((x) => Deliveryto.fromJson(x))),
    deliveryto: List<Deliveryto>.from(json["deliveryto"].map((x) => Deliveryto.fromJson(x))),
    loadproduct: List<Deliveryto>.from(json["loadproduct"].map((x) => Deliveryto.fromJson(x))),
    desttype: List<Deliveryto>.from(json["desttype"].map((x) => Deliveryto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quantitylist": List<dynamic>.from(quantitylist!.map((x) => x.toJson())),
    "deliveryto": List<dynamic>.from(deliveryto!.map((x) => x.toJson())),
    "loadproduct": List<dynamic>.from(loadproduct!.map((x) => x.toJson())),
    "desttype": List<dynamic>.from(desttype!.map((x) => x.toJson())),
  };
}

class Deliveryto {
  Deliveryto({
    this.id,
    this.name,
    this.value,
    this.image,
  });

  int? id;
  String? name;
  String? value;
  String? image;

  factory Deliveryto.fromJson(Map<String, dynamic> json) => Deliveryto(
    id: json["id"],
    name: json["name"],
    value: json["value"] == null ? null : json["value"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "value": value == null ? null : value,
    "image": image,
  };
}
