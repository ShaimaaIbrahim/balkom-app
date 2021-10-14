import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/core/responses/empty_response.dart';
import 'package:ojos_app/features/order/data/api_responses/general_order_item_response.dart';
import 'package:ojos_app/features/order/data/models/general_order_item_model.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'order_remote_data_source.dart';

class ConcreteOrderRemoteDataSource extends OrderRemoteDataSource {
  @override
  Future<Either<BaseError, List<GeneralOrderItemModel>>> fetchOrders({
    int? pagesize,
    int? page,
    Map<String, String>? filterParams,
    CancelToken? cancelToken,
  }) {
    Map<String, String> queryParams = {};
    if (filterParams != null) {
      filterParams
          .forEach((key, value) => queryParams.putIfAbsent(key, () => value));
    }
    // if (pagesize != null)
    //   queryParams.putIfAbsent('pagesize', () => pagesize.toString());
    // if (page != null) queryParams.putIfAbsent('page', () => page.toString());

    return request<List<GeneralOrderItemModel>, GeneralOrderItemResponse>(
      responseStr: 'GeneralOrderItemResponse',
      converter: (json) => GeneralOrderItemResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_GET_ORDER,
      queryParameters: queryParams,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> sendOrder(
      {OrderRequest? orderRequest, CancelToken? cancelToken}) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      withAuthentication: true,
      url: API_SEND_ORDER,
      data: orderRequest!.toJson(),
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> deleteOrder({
    int? id,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.DELETE,
      withAuthentication: true,
      url: API_GET_ORDER + "/$id",
      cancelToken: cancelToken!,
    );
  }
}
