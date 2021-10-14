import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/remote_data_source.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/product/data/models/product_favorite_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<ProductModel>>> fetchProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    bool? isFromSearchPage,
    required CancelToken cancelToken,
  });
  Future<Either<BaseError, List<ProductModel>>> getTestResult({
    Map<String, dynamic>? filterParams,
    required CancelToken cancelToken,
  });
  Future<Either<BaseError, List<ProductModel>>> getMyProductsResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  });

  Future<Either<BaseError, ProductDetailsModel>> fetchProductDetails({
    required int id,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<ProductFavoriteModel>>> fetchFavoriteProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> addOrRemoveFavorite({
    required int productID,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> addReview({
    required int productID,
    required String review,
    required double rate,
    required CancelToken cancelToken,
  });
}
