import 'package:dio/dio.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/core/errors/base_error.dart';

class SendOrdersParams extends BaseParams {
  final OrderRequest? request;

  SendOrdersParams({
    this.request,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class SendOrders extends UseCase<Object, SendOrdersParams> {
  final OrderRepository repository;

  SendOrders(this.repository);

  @override
  Future<Result<BaseError, Object>> call(SendOrdersParams params) {
    return repository.sendOrder(
      request: params.request!,
      cancelToken: params.cancelToken,
    );
  }
}
