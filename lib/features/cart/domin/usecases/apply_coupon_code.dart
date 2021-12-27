import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ojos_app/features/cart/domin/repositories/cartr_repository.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';

class ApplyCouponCodeParams extends BaseParams {
  final String total;
  final String couponCode;

  ApplyCouponCodeParams({
    required this.total,
    required this.couponCode,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class ApplyCouponCode extends UseCase<CouponCodeEntity, ApplyCouponCodeParams> {
  final CartRepository repository;

  ApplyCouponCode(this.repository);

  @override
  Future<Result<BaseError, CouponCodeEntity>> call(ApplyCouponCodeParams params) {
    return repository.applyCouponCode(
      total: params.total,
      couponCode: params.couponCode,
      cancelToken: params.cancelToken,
    );
  }
}
