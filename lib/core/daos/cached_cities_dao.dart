import 'package:ojos_app/core/models/shipping_carriers_model.dart';
import 'package:ojos_app/features/order/data/models/city_order_model.dart';
import '../constants.dart';
import 'base_dao.dart';

class CachedCitiesDao extends BaseDao<CityOrderModel> {
  CachedCitiesDao()
      : super(
    BOX_CITY,
          (c) => c.toJson(),
          (json) => CityOrderModel.fromJson(json),
          (c) => c.id.toString(),
        );
}