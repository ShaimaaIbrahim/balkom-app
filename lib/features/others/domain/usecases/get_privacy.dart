import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';
import 'package:ojos_app/features/others/domain/entity/privacy_result.dart';


class GetPrivacyAppParams extends BaseParams {
  final bool isPrivacyApp;
  GetPrivacyAppParams({
    this.isPrivacyApp = false,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class GetPrivacyApp extends UseCase<PrivacyAppResult, GetPrivacyAppParams> {
  final CoreRepository repository;

  GetPrivacyApp(this.repository);

  @override
  Future<Result<BaseError, PrivacyAppResult>> call(GetPrivacyAppParams params) {
    return repository.getPrivacyAppInfo(
      isPrivacy: params.isPrivacyApp,
      cancelToken: params.cancelToken,
    );
  }
}
