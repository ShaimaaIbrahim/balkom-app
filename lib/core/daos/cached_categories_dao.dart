import 'package:ojos_app/core/models/category_model.dart';
import '../constants.dart';
import 'base_dao.dart';

class CachedCategoriesDao extends BaseDao<CategoryModel> {
  CachedCategoriesDao()
      : super(
          BOX_CATEGORY,
          (c) => c.toJson(),
          (json) => CategoryModel.fromJson(json),
          (c) => c.id.toString(),
        );
}
