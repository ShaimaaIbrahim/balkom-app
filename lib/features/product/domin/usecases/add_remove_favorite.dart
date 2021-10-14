import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';

class AddOrRemoveFavoriteParams extends BaseParams {
  final int productId;

  AddOrRemoveFavoriteParams({
    required this.productId,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class AddOrRemoveFavorite extends UseCase<Object, AddOrRemoveFavoriteParams> {
  final ProductRepository repository;

  AddOrRemoveFavorite(this.repository);

  @override
  Future<Result<BaseError, Object>> call(AddOrRemoveFavoriteParams params) {
    return repository.addOrRemoveFavorite(
      productID: params.productId,
      cancelToken: params.cancelToken,
    );
  }
}
