import 'package:ojos_app/core/models/brand_model.dart';
import '../constants.dart';
import 'base_dao.dart';

class CachedBrandsDao extends BaseDao<BrandModel> {
  CachedBrandsDao()
      : super(
    BOX_Brand,
          (c) => c.toJson(),
          (json) => BrandModel.fromJson(json),
          (c) => c.id.toString(),
        );
}
