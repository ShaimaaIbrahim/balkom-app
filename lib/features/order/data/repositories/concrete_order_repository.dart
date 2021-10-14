import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:ojos_app/features/order/data/models/general_order_item_model.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';
import 'package:ojos_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/product/data/models/product_favorite_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';

class ConcreteOrderRepository extends OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  ConcreteOrderRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, List<GeneralOrderItemEntity>>> getOrders({
    int? pagesize,
    int? page,
    Map<String, String>? filterParams,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.fetchOrders(
      pagesize: pagesize!,
      page: page!,
      filterParams: filterParams!,
      cancelToken: cancelToken!,
    );
    return executeForList<GeneralOrderItemModel, GeneralOrderItemEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> sendOrder({
    OrderRequest? request,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.sendOrder(
      orderRequest: request!,
      cancelToken: cancelToken!,
    );

    return executeForNoData(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> deleteOrder({
    int? id,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.deleteOrder(
      id: id!,
      cancelToken: cancelToken!,
    );

    return executeForNoData(
      remoteResult: remoteResult,
    );
  }
}
