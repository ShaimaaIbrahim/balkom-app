import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/core/responses/empty_response.dart';
import 'package:ojos_app/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/login_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/register_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/verify_request.dart';
import 'package:ojos_app/features/user_management/data/api_responses/forget_response.dart';
import 'package:ojos_app/features/user_management/data/api_responses/login_response.dart';
import 'package:ojos_app/features/user_management/data/api_responses/register_response.dart';
import 'package:ojos_app/features/user_management/data/api_responses/verify_mobile_number_response.dart';
import 'package:ojos_app/features/user_management/data/datasources/user_remote_data_source.dart';
import 'package:ojos_app/features/user_management/data/models/forget_result_model.dart';
import 'package:ojos_app/features/user_management/data/models/login_result_model.dart';
import 'package:ojos_app/features/user_management/data/models/register_result_model.dart';
import 'package:ojos_app/features/user_management/data/models/verify_result_model.dart';
import 'package:flutter/foundation.dart';

class ConcreteUserRemoteDataSource extends UserRemoteDataSource {
  @override
  Future<Either<BaseError, RegisterResultModel>> register({
    RegisterRequest? data,
    CancelToken? cancelToken,
  }) {
    return request<RegisterResultModel, RegisterResponse>(
      responseStr: 'RegisterResponse',
      converter: (json) => RegisterResponse.fromJson(json),
      method: HttpMethod.POST,
      data: data!.toJson(),
      url: API_AUTH_REGISTER,
      withAuthentication: false,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> verify({
    VerifyRequest? data,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      data: data!.toJson(),
      url: API_AUTH_VERIFY,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> reSendCode({
    String? username,
    String? device_token,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_AUTH_RESEND_CODE,
      data: {'mobile': username, 'device_token ': device_token!},
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, LoginResultModel>> login({
    LoginRequest? data,
    CancelToken? cancelToken,
  }) {
    return request<LoginResultModel, LoginResponse>(
      responseStr: 'LoginResponse',
      converter: (json) => LoginResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_AUTH_LOGIN,
      data: data!.toJson(),
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> changePassword({
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_AUTH_CHANGE_PASSWORD,
      queryParameters: queryParameters!,
      data: queryParameters,
      cancelToken: cancelToken!,
      withAuthentication: true,
    );
  }

  @override
  Future<Either<BaseError, Object>> resetPassword({
    ResetPasswordRequest? data,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_AUTH_RESET_PASSWORD,
      data: data!.toJson(),
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, ForgetResultModel>> forgotPassword({
    ForgotPasswordRequest? data,
    CancelToken? cancelToken,
  }) {
    return request<ForgetResultModel, ForgetResponse>(
      responseStr: 'ForgetResponse',
      converter: (json) => ForgetResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_AUTH_FORGOT_PASSWORD,
      data: data!.toJson(),
      cancelToken: cancelToken!,
    );
  }

  ///===========================================================================
  // @override
  // Future<Either<BaseError, VerifyResultModel>> registerPhoneNumber({
  //   Map<String, dynamic> data,
  //   CancelToken cancelToken,
  // }) {
  //   return request<VerifyResultModel, VerifyMobilNumberResponse>(
  //     responseStr: 'VerifyMobilNumberResponse',
  //     converter: (json) => VerifyMobilNumberResponse.fromJson(json),
  //     method: HttpMethod.POST,
  //     queryParameters: data,
  //     //url: API_AUTH_REGISTER_PHONE_NUMBER,
  //     withAuthentication: false,
  //     cancelToken: cancelToken,
  //   );
  // }

  @override
  Future<Either<BaseError, Object>> resendCode({
    Map<String, dynamic>? queryParameters,
    String? urlResendCode,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      queryParameters: queryParameters!,
      url: urlResendCode!,
      withAuthentication: true,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> forgetPassword({
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      queryParameters: queryParameters,
      url: API_AUTH_FORGOT_PASSWORD,
      withAuthentication: false,
      cancelToken: cancelToken!,
    );
  }

  @override
  Future<Either<BaseError, Object>> verifiedForgotPassword({
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      queryParameters: queryParameters,
      //url: API_AUTH_VERIFIED_FORGOT_PASSWORD,
      url: API_AUTH_FORGOT_PASSWORD,
      withAuthentication: false,
      cancelToken: cancelToken!,
    );
  }

  ///****

  @override
  Future<Either<BaseError, Object>> changeUserNamePhoneNumberOrEmail({
    Map<String, dynamic>? queryParameters,
    String? changeUserNameUrl,
    CancelToken? cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: changeUserNameUrl!,
      queryParameters: queryParameters!,
      cancelToken: cancelToken!,
      withAuthentication: true,
    );
  }
}
