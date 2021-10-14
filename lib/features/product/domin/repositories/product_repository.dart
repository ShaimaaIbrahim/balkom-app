import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/repositories/repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';

abstract class ProductRepository extends Repository {
  Future<Result<BaseError, List<ProductEntity>>> getProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    bool? isFromSearchPage,
    CancelToken? cancelToken,
  });
  Future<Result<BaseError, List<ProductEntity>>> getTestResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  });

  Future<Result<BaseError, List<ProductEntity>>> getMyProductsResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  });

  Future<Result<BaseError, ProductDetailsEntity>> getProductDetails({
    required int id,
    CancelToken? cancelToken,
  });

  Future<Result<BaseError, List<ProductFavoriteEntity>>> fetchFavoriteProducts({
    int? pagesize,
    int? page,
    Map<String, String>? filterParams,
    CancelToken? cancelToken,
  });

  Future<Result<BaseError, Object>> addOrRemoveFavorite({
    required int productID,
    CancelToken? cancelToken,
  });

  Future<Result<BaseError, Object>> addReview({
    required int productID,
    required String review,
    required double rate,
    CancelToken? cancelToken,
  });
}
