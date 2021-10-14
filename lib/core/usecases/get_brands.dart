import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';

import 'usecase.dart';

class GetBrands extends UseCase<List<BrandEntity>, NoParams> {
  final CoreRepository repository;

  GetBrands(this.repository);

  @override
  Future<Result<BaseError, List<BrandEntity>>> call(NoParams params) =>
      repository.getBrands(cancelToken: params.cancelToken);
}
