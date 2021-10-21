import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';

class DeleteNotificationParams extends BaseParams {
  String id;

  DeleteNotificationParams({
    required this.id,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class DeleteNotificationUseCase
    extends UseCase<Object, DeleteNotificationParams> {
  final CoreRepository repository;

  DeleteNotificationUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(DeleteNotificationParams params) =>
      repository.deleteNotification(
        id: params.id,
        cancelToken: params.cancelToken,
      );
}
