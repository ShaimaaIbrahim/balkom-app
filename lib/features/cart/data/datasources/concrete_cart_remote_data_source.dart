import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/core/responses/empty_response.dart';
import 'package:ojos_app/features/cart/data/api_responses/coupon_code_response.dart';
import 'package:ojos_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ojos_app/features/cart/data/models/coupon_code_model.dart';
import 'package:ojos_app/features/cart/domin/entities/retrieve_request.dart';

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

  // @override
  // Future<Either<BaseError, EmptyResponse>> applyRetrieve(
  //     {String? name,
  //     String? reason,
  //     String? place,
  //     String? phone,
  //     String? productId,
  //     CancelToken? cancelToken}) {
    // return request<EmptyResponse, Respo>(
    //   responseStr: 'CouponCodeResponse',
    //   converter: (json) => '',
    //   method: HttpMethod.POST,
    //   url: API_EXECUTE_COUPON,
    //   withAuthentication: true,
    //   data: {'couponcode': couponCode!, 'total': total!},
    //   cancelToken: cancelToken!,
    // );
  }
