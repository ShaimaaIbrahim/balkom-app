import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/account_not_verified_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/errors/login_required_error.dart';
import 'package:ojos_app/core/errors/unknown_error.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';

import '../appConfig.dart';
import '../constants.dart';
import '../errors/base_error.dart';
import '../http/api_provider.dart';
import '../http/http_method.dart';
import '../http/models_factory.dart';
import '../responses/api_response.dart';

abstract class RemoteDataSource {
  Future<Either<BaseError, Data>>
      requestUploadFile<Data, Response extends ApiResponse<Data>>({
    required String responseStr,
    required Response Function(Map<String, dynamic>) converter,
    required String url,
    required String fileKey,
    required String filePath,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withAuthentication = false,
    required CancelToken cancelToken,
  }) async {
    // Register the response.
    ModelsFactory.getInstance().registerModel(
      responseStr,
      converter,
    );

    // Specify the headers.
    final Map<String, String> headers = {};
    headers.putIfAbsent(HEADER_CONTENT_TYPE, () => 'application/json');
    headers.putIfAbsent(HEADER_ACCEPT, () => 'application/json');
    // Get auth token (if withAuthentication)
    if (withAuthentication) {
      if (await UserRepository.hasToken) {
        final token = await UserRepository.authToken;
        //  headers.putIfAbsent(HEADER_AUTH, () => 'Bearer $token');
        headers.putIfAbsent(HEADER_AUTH, () => 'Bearer $token');
      }
    }

    // Send the request.
    final response = await ApiProvider.uploadFile<Response>(
      url: url,
      fileKey: fileKey,
      filePath: filePath,
      fileName: filePath.substring(filePath.lastIndexOf('/') + 1),
      data: data!,
      queryParameters: queryParameters ?? {},
      headers: headers,
      onSendProgress: onSendProgress!,
      onReceiveProgress: onReceiveProgress!,
      cancelToken: cancelToken,
    );

    if (response.isLeft()) {
      return Left((response as Left<BaseError, Response>).value);
    } else if (response.isRight()) {
      final resValue = (response as Right<BaseError, Response>).value;
      if (resValue.status != null && resValue.status!) {
        return Right(resValue.result);
      } else if (resValue.status != null && !resValue.status!) {
        final messageCode = -1;
        switch (messageCode) {
          case MESSAGE_CODE_ACCOUNT_NOT_VERIFIED:
            return Left(AccountNotVerifiedError());
          case MESSAGE_CODE_LOGIN_REQUIRED:
            return Left(LoginRequiredError());
          default:
            return Left(CustomError(message: resValue.msg!));
        }
      }
      return Left(UnknownError());
    }
    return Left(UnknownError());
  }

  Future<Either<BaseError, Data>>
      request<Data, Response extends ApiResponse<Data>>({
    required String responseStr,
    required Response Function(Map<String, dynamic>) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool withAuthentication = false,
    required CancelToken cancelToken,
  }) async {
    // Register the response.
    ModelsFactory.getInstance().registerModel(responseStr, converter);

    // Specify the headers.
    final Map<String, dynamic> headers = {};

    // Get the language.
    final lang = await appConfig.currentLanguage;

    headers.putIfAbsent(HEADER_LANGUAGE, () => lang);
    headers.putIfAbsent(HEADER_CONTENT_TYPE, () => 'application/json');
    headers.putIfAbsent(HEADER_ACCEPT, () => 'application/json');
    if (withAuthentication) {
      if (await UserRepository.hasToken) {
        final token = await UserRepository.authToken;
        headers.putIfAbsent(HEADER_AUTH, () => 'Bearer $token');
      }
    }

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters ?? {},
      data: data,
      cancelToken: cancelToken,
    );

    if (response != null && response.isLeft()) {
      return Left(((response as Left<BaseError, Response>).value));
    } else if (response != null && response.isRight()) {
      final resValue = (response as Right<BaseError, Response>).value;
      if (resValue.status != null && resValue.status!) {
        return Right(resValue.result);
      } else if (resValue.status != null && !resValue.status!) {
        final messageCode = -1;
        switch (messageCode) {
          case MESSAGE_CODE_ACCOUNT_NOT_VERIFIED:
            return Left(AccountNotVerifiedError());
          case MESSAGE_CODE_LOGIN_REQUIRED:
            return Left(LoginRequiredError());
          default:
            return Left(CustomError(message: resValue.msg!));
        }
      }
      return Left(UnknownError());
    }
    return Left(UnknownError());
  }
}
