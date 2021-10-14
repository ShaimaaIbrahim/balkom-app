import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';

class GetAboutAppParams extends BaseParams {
  GetAboutAppParams({
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class GetAboutApp extends UseCase<AboutAppResult, GetAboutAppParams> {
  final CoreRepository repository;

  GetAboutApp(this.repository);

  @override
  Future<Result<BaseError, AboutAppResult>> call(GetAboutAppParams params) {
    return repository.getAboutAppInfo(
      cancelToken: params.cancelToken,
    );
  }
}
