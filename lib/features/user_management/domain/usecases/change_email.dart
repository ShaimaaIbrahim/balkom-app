import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/user_management/data/api_requests/change_email_request.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class ChangUserNamePhoneNumberOrEmailParams extends BaseParams {
  final Map<String, dynamic> queryParameters;
  final String changeUserNameUrl;
  ChangUserNamePhoneNumberOrEmailParams({
    required this.queryParameters,
    required this.changeUserNameUrl,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class ChangeUserNamePhoneNumberOrEmailUseCase extends UseCase<Object, ChangUserNamePhoneNumberOrEmailParams> {
  final UserRepository repository;

  ChangeUserNamePhoneNumberOrEmailUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ChangUserNamePhoneNumberOrEmailParams params) =>
      repository.changeUserNamePhoneNumberOrEmail(
         queryParameters: params.queryParameters,
         changeUserNameUrl: params.changeUserNameUrl,
        cancelToken: params.cancelToken,
      );
}
