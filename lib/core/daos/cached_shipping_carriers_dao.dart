import 'package:ojos_app/core/models/shipping_carriers_model.dart';
import '../constants.dart';
import 'base_dao.dart';

class CachedShippingCarriersDao extends BaseDao<ShippingCarriersModel> {
  CachedShippingCarriersDao()
      : super(
    BOX_SHIPPING_CARRIERS,
          (c) => c.toJson(),
          (json) => ShippingCarriersModel.fromJson(json),
          (c) => c.id.toString(),
        );
}
