class SendOrderResponse {
  int? city_id;
  int? coupon_id;
  String? created_at;
  int? delivery_fee;
  int? delivery_to;
  String? description;
  Object? dest_name;
  Object? dest_type;
  double? discount;
  Object? guard_number;
  int? id;
  int? load_id;
  int? method_id;
  int? neighborhood_id;
  String? note;
  int? paid_amount;
  int? quantity_id;
  int? remaining_amount;
  String? status;
  int? subtotal;
  int? tax;
  int? total;
  String? updated_at;
  int? user_id;
  String? uuid;

  SendOrderResponse(
      {this.city_id,
      this.coupon_id,
      this.created_at,
      this.delivery_fee,
      this.delivery_to,
      this.description,
      this.dest_name,
      this.dest_type,
      this.discount,
      this.guard_number,
      this.id,
      this.load_id,
      this.method_id,
      this.neighborhood_id,
      this.note,
      this.paid_amount,
      this.quantity_id,
      this.remaining_amount,
      this.status,
      this.subtotal,
      this.tax,
      this.total,
      this.updated_at,
      this.user_id,
      this.uuid});

  factory SendOrderResponse.fromJson(Map<String, dynamic> json) {
    return SendOrderResponse(
      city_id: json['city_id'],
      coupon_id: json['coupon_id'],
      created_at: json['created_at'],
      delivery_fee: json['delivery_fee'],
      delivery_to: json['delivery_to'],
      description: json['description'],
      dest_name: json['dest_name'],
      dest_type: json['dest_type'],
      discount: json['discount'],
      guard_number: json['guard_number'] as Object?,
      id: json['id'],
      load_id: json['load_id'],
      method_id: json['method_id'],
      neighborhood_id: json['neighborhood_id'],
      note: json['note'],
      paid_amount: json['paid_amount'],
      quantity_id: json['quantity_id'],
      remaining_amount: json['remaining_amount'],
      status: json['status'],
      subtotal: json['subtotal'],
      tax: json['tax'],
      total: json['total'],
      updated_at: json['updated_at'],
      user_id: json['user_id'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.city_id;
    data['coupon_id'] = this.coupon_id;
    data['created_at'] = this.created_at;
    data['delivery_fee'] = this.delivery_fee;
    data['delivery_to'] = this.delivery_to;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['id'] = this.id;
    data['load_id'] = this.load_id;
    data['method_id'] = this.method_id;
    data['neighborhood_id'] = this.neighborhood_id;
    data['note'] = this.note;
    data['paid_amount'] = this.paid_amount;
    data['quantity_id'] = this.quantity_id;
    data['remaining_amount'] = this.remaining_amount;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    data['updated_at'] = this.updated_at;
    data['user_id'] = this.user_id;
    data['uuid'] = this.uuid;

    data['dest_name'] = this.dest_name!;
    data['dest_type'] = this.dest_type!;
    data['guard_number'] = this.guard_number;

    return data;
  }
}
