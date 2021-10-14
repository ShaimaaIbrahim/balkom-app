import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';

class ReSendCodeParams extends BaseParams {
  final String mobile;
  final String device_token;

  ReSendCodeParams({
    required this.mobile,
    required this.device_token,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class ReSendCode extends UseCase<Object, ReSendCodeParams> {
  final UserRepository repository;

  ReSendCode(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ReSendCodeParams params) =>
      repository.reSendCode(
        username: params.mobile,
        device_token: params.device_token,
        cancelToken: params.cancelToken,
      );
}
