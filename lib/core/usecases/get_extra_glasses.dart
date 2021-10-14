import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';

import 'usecase.dart';

class GetExtraGlasses extends UseCase<ExtraGlassesEntity, NoParams> {
  final CoreRepository repository;

  GetExtraGlasses(this.repository);

  @override
  Future<Result<BaseError, ExtraGlassesEntity>> call(NoParams params) =>
      repository.getExtraGlasses(cancelToken: params.cancelToken);
}
