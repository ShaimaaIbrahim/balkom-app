import 'package:dio/dio.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/core/errors/base_error.dart';

class GetTestParams extends BaseParams {
  final Map<String, dynamic>? filterParams;

  GetTestParams({
    this.filterParams,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetTest extends UseCase<List<ProductEntity>, GetTestParams> {
  final ProductRepository repository;

  GetTest(this.repository);

  @override
  Future<Result<BaseError, List<ProductEntity>>> call(GetTestParams params) {
    return repository.getTestResult(
      filterParams: params.filterParams!,
      cancelToken: params.cancelToken,
    );
  }
}
