import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/features/cart/data/api_responses/coupon_code_response.dart';
import 'package:ojos_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ojos_app/features/cart/data/models/coupon_code_model.dart';

class ConcreteCartRemoteDataSource extends CartRemoteDataSource {
  @override
  Future<Either<BaseError, CouponCodeModel>> applyCouponCode({
    String? total,
    String? couponCode,
    CancelToken? cancelToken,
  }) {
    return request<CouponCodeModel, CouponCodeResponse>(
      responseStr: 'CouponCodeResponse',
      converter: (json) => CouponCodeResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_EXECUTE_COUPON,
      withAuthentication: true,
      data: {'couponcode': couponCode!, 'total': total!},
      cancelToken: cancelToken!,
    );
  }
}
