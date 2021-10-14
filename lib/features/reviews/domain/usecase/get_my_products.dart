import 'package:dio/dio.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/core/errors/base_error.dart';

class GetMyProductsParams extends BaseParams {
  final Map<String, dynamic>? filterParams;

  GetMyProductsParams({
    this.filterParams,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetMyProducts extends UseCase<List<ProductEntity>, GetMyProductsParams> {
  final ProductRepository repository;

  GetMyProducts(this.repository);

  @override
  Future<Result<BaseError, List<ProductEntity>>> call(
      GetMyProductsParams params) {
    return repository.getMyProductsResult(
      filterParams: params.filterParams!,
      cancelToken: params.cancelToken,
    );
  }
}
