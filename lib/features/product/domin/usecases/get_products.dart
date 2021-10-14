import 'package:dio/dio.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/core/errors/base_error.dart';

class GetProductParams extends BaseParams {
  final Map<String, dynamic> filterParams;
  final int pagesize;
  final int page;
  final bool isFromSearchPage;

  GetProductParams({
    required this.filterParams,
    required this.pagesize,
    required this.page,
    this.isFromSearchPage = false,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetProduct extends UseCase<List<ProductEntity>, GetProductParams> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Result<BaseError, List<ProductEntity>>> call(GetProductParams params) {
    return repository.getProducts(
      pagesize: params.pagesize,
      page: params.page,
      filterParams: params.filterParams,
      isFromSearchPage: params.isFromSearchPage,
      cancelToken: params.cancelToken,
    );
  }
}
