import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/responses/empty_response.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ojos_app/features/cart/data/models/coupon_code_model.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ojos_app/features/cart/domin/repositories/cartr_repository.dart';

class ConcreteCartRepository extends CartRepository {
  final CartRemoteDataSource remoteDataSource;

  ConcreteCartRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, CouponCodeEntity>> applyCouponCode({
    String? total,
    String? couponCode,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.applyCouponCode(
      total: total!,
      couponCode: couponCode!,
      cancelToken: cancelToken!,
    );
    return execute<CouponCodeModel, CouponCodeEntity>(
        remoteResult: remoteResult);
  }

  // @override
  // Future<Result<BaseError, Object>> applyRetrieve(
  //     {String? reason,
  //     String? place,
  //     String? name,
  //     String? phone,
  //     String? productId,
  //     CancelToken? cancelToken}) async {
  //   final remoteResult = await remoteDataSource.applyRetrieve(
  //     cancelToken: cancelToken!,
  //     productId: productId!,
  //     name: name!,
  //     reason: reason!,
  //     place: place!,
  //     phone: phone!,
  //   );
  //   return executeForNoData(remoteResult: remoteResult);
  // }
}
