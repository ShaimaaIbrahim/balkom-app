import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';

import 'usecase.dart';

class GetOffers extends UseCase<OfferEntity, NoParams> {
  final CoreRepository repository;

  GetOffers(this.repository);

  @override
  Future<Result<BaseError, OfferEntity>> call(NoParams params) =>
      repository.getOffers(cancelToken: params.cancelToken);
}
