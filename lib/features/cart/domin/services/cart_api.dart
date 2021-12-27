import 'package:dio/dio.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/features/cart/data/api_responses/retrieve_response.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';

class CartApi {

  String API_RETRIEVE_ORDER = "https://bilqom.com/api/auth/product-retriev";

  Future<RetrieveResponse> retrieveOrder(
      bool withAuthentication,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      CancelToken cancelToken) async {
    try {
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
      Response response = await Dio().post(
        API_RETRIEVE_ORDER,
        queryParameters: queryParameters ?? {},
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return RetrieveResponse.fromJson(response.data);
    }
    // Handling errors
    on DioError catch (e) {
      print('Exception is DioError $e');
      print('Exception is DioError message ${e.message}');
      print(
          'Exception is DioError requestOptions.headers ${e.requestOptions.headers}');
      print('Exception is DioError error ${e.error}');
      print('Exception is DioError request.data ${e.requestOptions.data}');
      print('Exception is DioError path ${e.requestOptions.path}');
      print('Exception is DioError response ${e.response}');
      return RetrieveResponse.fromJson({});
    }
  }
}
