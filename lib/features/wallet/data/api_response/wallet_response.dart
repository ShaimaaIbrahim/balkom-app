class WalletResponse {
  WalletResponse({
      List<Data>? data,}){
    _data = data;
}

  WalletResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      int? id, 
      List<String>? productName, 
      String? clientName, 
      String? walletAmount, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _productName = productName;
    _clientName = clientName;
    _walletAmount = walletAmount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _productName = json['product_name'] != null ? json['product_name'].cast<String>() : [];
    _clientName = json['client_name'];
    _walletAmount = json['wallet_amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  List<String>? _productName;
  String? _clientName;
  String? _walletAmount;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  List<String>? get productName => _productName;
  String? get clientName => _clientName;
  String? get walletAmount => _walletAmount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product_name'] = _productName;
    map['client_name'] = _clientName;
    map['wallet_amount'] = _walletAmount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}