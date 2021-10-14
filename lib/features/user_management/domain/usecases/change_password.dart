import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordParams extends BaseParams {
  final Map<String, dynamic> queryParameters;

  ChangePasswordParams({
    required this.queryParameters,
    CancelToken? cancelToken,
  })  : assert(cancelToken != null),
        super(cancelToken: cancelToken!);
}

class ChangePasswordUseCase extends UseCase<Object, ChangePasswordParams> {
  final UserRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ChangePasswordParams params) =>
      repository.changePassword(
        queryParameters: params.queryParameters,
        cancelToken: params.cancelToken,
      );
}
