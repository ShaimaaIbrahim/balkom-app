import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/remote_data_source.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/order/data/models/general_order_item_model.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';

abstract class OrderRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<GeneralOrderItemModel>>> fetchOrders({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> sendOrder({
    OrderRequest orderRequest,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> deleteOrder({
    required int id,
    CancelToken cancelToken,
  });
}
