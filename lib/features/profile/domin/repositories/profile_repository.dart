import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/repositories/repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';


abstract class ProfileRepository extends Repository {

  Future<Result<BaseError, ProfileEntity>> getUserData({
    CancelToken cancelToken,
  });

  Future<Result<BaseError, ProfileEntity>> updateProfile({
    String name,
    String email,
    String address,
    String mobile,
   String device_token,
    String aboutMe,
    String photo,
    CancelToken cancelToken,
  });
}
