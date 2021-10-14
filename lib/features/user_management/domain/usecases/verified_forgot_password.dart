import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class VerifiedForgetPasswordParams extends BaseParams {
  final Map<String, dynamic> queryParameters;

  VerifiedForgetPasswordParams({
    required this.queryParameters,
    CancelToken? cancelToken,
  })  : assert(cancelToken != null),
        super(cancelToken: cancelToken!);
}

class VerifiedForgetPasswordUseCase
    extends UseCase<Object, VerifiedForgetPasswordParams> {
  final UserRepository repository;

  VerifiedForgetPasswordUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(VerifiedForgetPasswordParams params) =>
      repository.verifiedForgotPassword(
        queryParameters: params.queryParameters,
        cancelToken: params.cancelToken,
      );
}
