import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/features/profile/data/api_responses/profile_response.dart';
import 'package:ojos_app/features/profile/data/models/profile_model.dart';

import 'profile_remote_data_source.dart';

class ConcreteProfileRemoteDataSource extends ProfileRemoteDataSource {
  @override
  Future<Either<BaseError, ProfileModel>> getUserData({
    CancelToken? cancelToken,
  }) {
    return request<ProfileModel, ProfileResponse>(
      responseStr: 'ProfileResponse',
      converter: (json) => ProfileResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_AUTH_USER_DETAILS,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, ProfileModel>> updateProfile({
    String? name,
    String? email,
    String? address,
    String? device_token,
    String? aboutMe,
    String? mobile,
    String? photo,
    CancelToken? cancelToken,
  }) async {
    Map<String, String> data = {};
    if (appConfig.notNullOrEmpty(name!)) data.putIfAbsent('name', () => name);
    if (appConfig.notNullOrEmpty(email!))
      data.putIfAbsent('email', () => email);
    if (appConfig.notNullOrEmpty(address!))
      data.putIfAbsent('address', () => address);
    if (appConfig.notNullOrEmpty(device_token!))
      data.putIfAbsent('device_token', () => device_token);
    if (appConfig.notNullOrEmpty(aboutMe!))
      data.putIfAbsent('about_me', () => aboutMe);
    if (appConfig.notNullOrEmpty(mobile!))
      data.putIfAbsent('mobile', () => mobile);
    print('phonephonephonephone $mobile');

    return appConfig.notNullOrEmpty(photo)
        ? requestUploadFile<ProfileModel, ProfileResponse>(
            responseStr: 'ProfileResponse',
            converter: (json) => ProfileResponse.fromJson(json),
            url: API_AUTH_UPDATE_PROFILE,
            fileKey: 'photo',
            filePath: photo!,
            data: data,
            withAuthentication: true,
            cancelToken: cancelToken!,
          )
        : request<ProfileModel, ProfileResponse>(
            responseStr: 'ProfileResponse',
            converter: (json) => ProfileResponse.fromJson(json),
            method: HttpMethod.POST,
            url: API_AUTH_UPDATE_PROFILE,
            withAuthentication: true,
            data: data,
            cancelToken: cancelToken!,
          );
  }
}
