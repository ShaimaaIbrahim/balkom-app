import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';

class GetProductDetailsParams extends BaseParams {
  final int id;

  GetProductDetailsParams({
    required this.id,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetProductDetails
    extends UseCase<ProductDetailsEntity, GetProductDetailsParams> {
  final ProductRepository repository;

  GetProductDetails(this.repository);

  @override
  Future<Result<BaseError, ProductDetailsEntity>> call(
      GetProductDetailsParams params) {
    return repository.getProductDetails(
      id: params.id,
      cancelToken: params.cancelToken,
    );
  }
}
