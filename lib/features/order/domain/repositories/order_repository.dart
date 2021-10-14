import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/repositories/repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';

abstract class OrderRepository extends Repository {
  Future<Result<BaseError, List<GeneralOrderItemEntity>>> getOrders({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });
  Future<Result<BaseError, Object>> sendOrder({
    required OrderRequest request,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> deleteOrder({
    required int id,
    CancelToken cancelToken,
  });
}
