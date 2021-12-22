/// status : true
/// msg : "Categories retrieved successfully"
/// result : [{"id":1,"name":"ماء","description":"ماء","image":"http://localhost/bilqom/uploads/products/435cd29c-2ae9-41bb-b8da-a7b98f7b91e7.jpg"}]

class GategoryRespone {
  GategoryRespone({
      bool? status, 
      String? msg, 
      List<Result>? result,}){
    _status = status;
    _msg = msg;
    _result = result;
}

  GategoryRespone.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  List<Result>? _result;

  bool? get status => _status;
  String? get msg => _msg;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "ماء"
/// description : "ماء"
/// image : "http://localhost/bilqom/uploads/products/435cd29c-2ae9-41bb-b8da-a7b98f7b91e7.jpg"

class Result {
  Result({
      int? id, 
      String? name, 
      String? description, 
      String? image,}){
    _id = id;
    _name = name;
    _description = description;
    _image = image;
}

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _description;
  String? _image;

  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    return map;
  }

}