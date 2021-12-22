/// order_id : 3
/// reason : "i dont need this itdsssfem :)"
/// place : "Caisdfro Egsssypt"
/// name : "Abdulrasdfhman"
/// phone : "+201012895020"

class RetrieveRequest {
  RetrieveRequest({
      int? orderId, 
      String? reason, 
      String? place, 
      String? name, 
      String? phone,}){
    _orderId = orderId;
    _reason = reason;
    _place = place;
    _name = name;
    _phone = phone;
}

  RetrieveRequest.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _reason = json['reason'];
    _place = json['place'];
    _name = json['name'];
    _phone = json['phone'];
  }
  int? _orderId;
  String? _reason;
  String? _place;
  String? _name;
  String? _phone;

  int? get orderId => _orderId;
  String? get reason => _reason;
  String? get place => _place;
  String? get name => _name;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['reason'] = _reason;
    map['place'] = _place;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }

}