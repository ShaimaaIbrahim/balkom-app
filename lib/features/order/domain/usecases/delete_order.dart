import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';

class DeleteOrderParams extends BaseParams {
  int id;

  DeleteOrderParams({
    required this.id,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class DeleteOrderUseCase extends UseCase<Object, DeleteOrderParams> {
  final OrderRepository repository;

  DeleteOrderUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(DeleteOrderParams params) =>
      repository.deleteOrder(
        id: params.id,
        cancelToken: params.cancelToken,
      );
}
