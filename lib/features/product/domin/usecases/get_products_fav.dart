import 'package:dio/dio.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/core/errors/base_error.dart';

class GetProductFavParams extends BaseParams {
  final Map<String, String> filterParams;
  final int pagesize;
  final int page;

  GetProductFavParams({
    required this.filterParams,
    required this.pagesize,
    required this.page,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetProductFav
    extends UseCase<List<ProductFavoriteEntity>, GetProductFavParams> {
  final ProductRepository repository;

  GetProductFav(this.repository);

  @override
  Future<Result<BaseError, List<ProductFavoriteEntity>>> call(
      GetProductFavParams params) {
    return repository.fetchFavoriteProducts(
      pagesize: params.pagesize,
      page: params.page,
      filterParams: params.filterParams,
      cancelToken: params.cancelToken,
    );
  }
}
