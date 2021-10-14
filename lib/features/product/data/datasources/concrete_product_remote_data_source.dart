import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/core/responses/empty_response.dart';
import 'package:ojos_app/features/product/data/api_responses/product_details_response.dart';
import 'package:ojos_app/features/product/data/api_responses/product_favorite_response.dart';
import 'package:ojos_app/features/product/data/api_responses/product_response.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/product/data/models/product_favorite_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';
import 'product_remote_data_source.dart';

class ConcreteProductRemoteDataSource extends ProductRemoteDataSource {
  @override
  Future<Either<BaseError, List<ProductModel>>> fetchProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    bool? isFromSearchPage,
    CancelToken? cancelToken,
  }) {
    Map<String, String> queryParams = {};
    if (filterParams != null) {
      filterParams
          .forEach((key, value) => queryParams.putIfAbsent(key, () => value));
    }
    // if (pagesize != null)
    //   queryParams.putIfAbsent('pagesize', () => pagesize.toString());
    if (page != null) queryParams.putIfAbsent('page', () => page.toString());

    return request<List<ProductModel>, ProductResponse>(
      responseStr: 'ProductResponse',
      converter: (json) => ProductResponse.fromJson(json),
      method: HttpMethod.GET,
      url: isFromSearchPage! ? API_GET_PRODUCTS_FILTER : API_GET_PRODUCTS,
      queryParameters: queryParams,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, List<ProductModel>>> getTestResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  }) {
    Map<String, String> queryParams = {};
    if (filterParams != null) {
      filterParams
          .forEach((key, value) => queryParams.putIfAbsent(key, () => value));
    }

    return request<List<ProductModel>, ProductResponse>(
      responseStr: 'ProductResponse',
      converter: (json) => ProductResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_GET_SEARCH_TEST,
      queryParameters: queryParams,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, List<ProductModel>>> getMyProductsResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  }) {
    Map<String, String> queryParams = {};
    if (filterParams != null) {
      filterParams
          .forEach((key, value) => queryParams.putIfAbsent(key, () => value));
    }

    return request<List<ProductModel>, ProductResponse>(
      responseStr: 'ProductResponse',
      converter: (json) => ProductResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_GET_MY_PRODUCTS,
      queryParameters: queryParams,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, ProductDetailsModel>> fetchProductDetails(
      {int? id, CancelToken? cancelToken}) {
    return request<ProductDetailsModel, ProductDetailsResponse>(
      responseStr: 'ProductDetailsResponse',
      converter: (json) => ProductDetailsResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_GET_PRODUCTS_DETAILS + '/${id.toString()}',
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, List<ProductFavoriteModel>>> fetchFavoriteProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  }) {
    Map<String, String> queryParams = {};
    if (filterParams != null) {
      filterParams
          .forEach((key, value) => queryParams.putIfAbsent(key, () => value));
    }
    // if (pagesize != null)
    //   queryParams.putIfAbsent('pagesize', () => pagesize.toString());
    if (page != null) queryParams.putIfAbsent('page', () => page.toString());

    return request<List<ProductFavoriteModel>, ProductFavoriteResponse>(
      responseStr: 'ProductFavoriteResponse',
      converter: (json) => ProductFavoriteResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_FAVORITES,
      queryParameters: queryParams,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> addOrRemoveFavorite({
    int? productID,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_FAVORITES,
      withAuthentication: true,
      data: {'product_id': productID.toString()},
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> addReview({
    int? productID,
    String? review,
    double? rate,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_REVIEW,
      withAuthentication: true,
      data: {
        'product_id': productID.toString(),
        "review": review,
        "rate": rate,
      },
      cancelToken: cancelToken!,
    );
  }
}
