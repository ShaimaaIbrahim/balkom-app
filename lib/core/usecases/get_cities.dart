import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/entities/shipping_carriers_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';
import 'usecase.dart';

class GetCities extends UseCase<List<CityOrderEntity>, NoParams> {
  final CoreRepository repository;

  GetCities(this.repository);

  @override
  Future<Result<BaseError, List<CityOrderEntity>>> call(NoParams params) =>
      repository.getCities(cancelToken: params.cancelToken);
}
