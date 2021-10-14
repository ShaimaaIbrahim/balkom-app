import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';

class ComplaintParams extends BaseParams {
  String name;
  String phone;
  String message;
  String email;

  ComplaintParams({
    required this.name,
    required this.phone,
    required this.message,
    required this.email,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class ComplaintUseCase extends UseCase<Object, ComplaintParams> {
  final CoreRepository repository;

  ComplaintUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ComplaintParams params) =>
      repository.complaint(
        phone: params.phone,
        name: params.name,
        message: params.message,
        email: params.email,
        cancelToken: params.cancelToken,
      );
}
