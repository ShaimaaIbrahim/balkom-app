import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/user_management/data/api_requests/register_request.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';
import 'package:ojos_app/features/user_management/domain/entities/register_result.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class RegisterParams extends BaseParams {
  RegisterRequest bodyParam;

  RegisterParams({
    required this.bodyParam,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class RegisterUseCase extends UseCase<RegisterResult, RegisterParams> {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Result<BaseError, RegisterResult>> call(RegisterParams params) =>
      repository.register(
        data: params.bodyParam,
        cancelToken: params.cancelToken,
      );
}
