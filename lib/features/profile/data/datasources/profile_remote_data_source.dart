import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/remote_data_source.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/cart/data/models/coupon_code_model.dart';
import 'package:ojos_app/features/product/data/models/product_details_model.dart';
import 'package:ojos_app/features/product/data/models/product_model.dart';
import 'package:ojos_app/features/profile/data/models/profile_model.dart';


abstract class ProfileRemoteDataSource extends RemoteDataSource {

  Future<Either<BaseError, ProfileModel>> getUserData({
    CancelToken cancelToken,
  });

  Future<Either<BaseError, ProfileModel>> updateProfile({
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
