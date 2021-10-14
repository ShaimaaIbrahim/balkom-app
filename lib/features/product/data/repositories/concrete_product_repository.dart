import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/product/data/models/product_favorite_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';

class ConcreteProductRepository extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ConcreteProductRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, List<ProductEntity>>> getProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    bool? isFromSearchPage,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.fetchProducts(
      pagesize: pagesize!,
      page: page!,
      filterParams: filterParams!,
      isFromSearchPage: isFromSearchPage!,
      cancelToken: cancelToken!,
    );
    return executeForList<ProductModel, ProductEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, List<ProductEntity>>> getTestResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.getTestResult(
      filterParams: filterParams!,
      cancelToken: cancelToken!,
    );
    return executeForList<ProductModel, ProductEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, List<ProductEntity>>> getMyProductsResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.getMyProductsResult(
      filterParams: filterParams!,
      cancelToken: cancelToken!,
    );
    return executeForList<ProductModel, ProductEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, ProductDetailsEntity>> getProductDetails(
      {int? id, CancelToken? cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchProductDetails(
      id: id!,
      cancelToken: cancelToken!,
    );
    return execute<ProductDetailsModel, ProductDetailsEntity>(
        remoteResult: remoteResult);
  }

  @override
  Future<Result<BaseError, List<ProductFavoriteEntity>>> fetchFavoriteProducts({
    int? pagesize,
    int? page,
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.fetchFavoriteProducts(
      pagesize: pagesize,
      page: page,
      filterParams: filterParams!,
      cancelToken: cancelToken!,
    );
    return executeForList<ProductFavoriteModel, ProductFavoriteEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> addOrRemoveFavorite({
    int? productID,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.addOrRemoveFavorite(
      productID: productID!,
      cancelToken: cancelToken!,
    );
    return executeForNoData(remoteResult: remoteResult);
  }

  @override
  Future<Result<BaseError, Object>> addReview({
    int? productID,
    String? review,
    double? rate,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.addReview(
      productID: productID!,
      review: review!,
      rate: rate!,
      cancelToken: cancelToken!,
    );
    return executeForNoData(remoteResult: remoteResult);
  }
}
