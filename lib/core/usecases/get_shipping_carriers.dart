import 'package:ojos_app/core/entities/shipping_carriers_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';

import 'usecase.dart';

class GetShippingCarriers
    extends UseCase<List<ShippingCarriersEntity>, NoParams> {
  final CoreRepository repository;

  GetShippingCarriers(this.repository);

  @override
  Future<Result<BaseError, List<ShippingCarriersEntity>>> call(
          NoParams params) =>
      repository.getShippingCarriers(cancelToken: params.cancelToken);
}
