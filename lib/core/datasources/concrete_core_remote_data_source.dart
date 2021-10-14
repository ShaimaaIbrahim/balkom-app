import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/datasources/core_remote_data_source.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/http/http_method.dart';
import 'package:ojos_app/core/models/brand_model.dart';
import 'package:ojos_app/core/models/category_model.dart';
import 'package:ojos_app/core/models/extra_glasses_model.dart';
import 'package:ojos_app/core/models/faqs_model.dart';
import 'package:ojos_app/core/models/notifications_model.dart';
import 'package:ojos_app/core/models/offer_model.dart';
import 'package:ojos_app/core/models/shipping_carriers_model.dart';
import 'package:ojos_app/core/models/wallet_transactions_model.dart';
import 'package:ojos_app/core/responses/brands_response.dart';
import 'package:ojos_app/core/responses/categories_response.dart';
import 'package:ojos_app/core/responses/city_response.dart';
import 'package:ojos_app/core/responses/empty_response.dart';
import 'package:ojos_app/core/responses/extra_glasses_response.dart';
import 'package:ojos_app/core/responses/faqs_response.dart';
import 'package:ojos_app/core/responses/notifications_response.dart';
import 'package:ojos_app/core/responses/offer_response.dart';
import 'package:ojos_app/core/responses/payment_method_response.dart';
import 'package:ojos_app/core/responses/shipping_carriers_response.dart';
import 'package:ojos_app/core/responses/wallet_transactions_response.dart';
import 'package:ojos_app/features/cart/data/models/payment_method_model.dart';
import 'package:ojos_app/features/order/data/models/city_order_model.dart';
import 'package:ojos_app/features/others/data/models/about_app_result_model.dart';
import 'package:ojos_app/features/others/data/models/privacy_app_result_model.dart';
import 'package:ojos_app/features/others/data/response/about_app_response.dart';
import 'package:ojos_app/features/others/data/response/privacy_app_response.dart';

class ConcreteCoreRemoteDataSource extends CoreRemoteDataSource {
  @override
  Future<Either<BaseError, Object>> changeAppLanguage(
      {required String lang, required CancelToken cancelToken}) {
    return request<Object, EmptyResponse>(
      converter: (json) => EmptyResponse.fromJson(json),
      responseStr: 'EmptyResponse',
      method: HttpMethod.GET,
      //s url: API_FIREBASE_NOTIFICATION_CHANGE_LANGUAGE,
      queryParameters: {'language': lang},
      withAuthentication: true,
      cancelToken: cancelToken,
      url: '',
    );
  }

  @override
  Future<Either<BaseError, ExtraGlassesModel>> fetchExtraGlasses({
    required CancelToken cancelToken,
  }) {
    return request<ExtraGlassesModel, ExtraGlassesResponse>(
      responseStr: 'ExtraGlassesResponse',
      converter: (json) => ExtraGlassesResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_GET_EXTRA_GLASSES,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, OfferModel>> fetchOffers({
    required CancelToken cancelToken,
  }) {
    return request<OfferModel, OfferResponse>(
      responseStr: 'OfferResponse',
      converter: (json) => OfferResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_GET_OFFERS,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<CategoryModel>>> fetchCategories({
    required CancelToken cancelToken,
  }) {
    return request<List<CategoryModel>, CategoriesResponse>(
      responseStr: 'CategoriesResponse',
      converter: (json) => CategoriesResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_CATEGORIES,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<ShippingCarriersModel>>> fetchShippingCarriers({
    required CancelToken cancelToken,
  }) {
    return request<List<ShippingCarriersModel>, ShippingCarriersResponse>(
      responseStr: 'ShippingCarriersResponse',
      converter: (json) => ShippingCarriersResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_SHIPPING_CARRIERS,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<CityOrderModel>>> fetchCities({
    required CancelToken cancelToken,
  }) {
    return request<List<CityOrderModel>, CityResponse>(
      responseStr: 'CityResponse',
      converter: (json) => CityResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_CITIES,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<PaymentMethodModel>>> fetchPaymentMethods({
    required CancelToken cancelToken,
  }) {
    return request<List<PaymentMethodModel>, PaymentMethodsResponse>(
      responseStr: 'PaymentMethodsResponse',
      converter: (json) => PaymentMethodsResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_PAYMENT_GETWAY,
      withAuthentication: true,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<BrandModel>>> fetchBrands({
    required CancelToken cancelToken,
  }) {
    return request<List<BrandModel>, BrandsResponse>(
      responseStr: 'BrandsResponse',
      converter: (json) => BrandsResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_BRANDS,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<NotificationsModel>>> getNotifications({
    required CancelToken cancelToken,
  }) {
    return request<List<NotificationsModel>, NotificationsResponse>(
      responseStr: 'NotificationsResponse',
      converter: (json) => NotificationsResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_NOTIFICATIONS,
      withAuthentication: true,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<FaqsModel>>> getFAQS({
    required CancelToken cancelToken,
  }) {
    return request<List<FaqsModel>, FaqsResponse>(
      responseStr: 'FaqsResponse',
      converter: (json) => FaqsResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_FAQS,
      withAuthentication: true,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, List<WalletTransactionsModel>>>
      getWalletTransactions({
    required CancelToken cancelToken,
  }) {
    return request<List<WalletTransactionsModel>, WalletTransactionsResponse>(
      responseStr: 'WalletTransactionsResponse',
      converter: (json) => WalletTransactionsResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_LISTS_WALLET_TRANSACTIONS,
      withAuthentication: true,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, Object>> contactUs({
    required String name,
    required String phone,
    required String message,
    required CancelToken cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      withAuthentication: true,
      url: API_POST_CONTACT_US,
      data: {'name': name, 'phone ': phone, 'message ': message},
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, Object>> complaint({
    required String name,
    required String phone,
    required String message,
    required String email,
    required CancelToken cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      withAuthentication: true,
      url: API_POST_PROBLEM_MSG,
      data: {
        'name': name,
        'phone ': phone,
        'message ': message,
        'email ': email,
      },
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, Object>> setNotification({
    required bool notify_new_product,
    required bool notify_wallet,
    required bool notify_offer,
    required CancelToken cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      withAuthentication: true,
      url: API_POST_SET_NOTIFICATION,
      data: {
        'notify_new_product': notify_new_product,
        'notify_wallet ': notify_wallet,
        'notify_offer ': notify_offer,
      },
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, Object>> deleteNotification({
    required String id,
    required CancelToken cancelToken,
  }) {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.DELETE,
      withAuthentication: true,
      url: API_LISTS_NOTIFICATIONS + "/$id",
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, AboutAppResultModel>> fetchAboutApp(
      {required CancelToken cancelToken}) {
    return request<AboutAppResultModel, AboutAppResponse>(
      responseStr: 'AboutAppResponse',
      converter: (json) => AboutAppResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_ABOUT_APP,
      withAuthentication: true,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, PrivacyAppResultModel>> fetchPrivacyApp(
      {required CancelToken cancelToken, required bool isPrivacy}) {
    return request<PrivacyAppResultModel, PrivacyAppResponse>(
      responseStr: 'PrivacyAppResponse',
      converter: (json) => PrivacyAppResponse.fromJson(json),
      method: HttpMethod.GET,
      url: isPrivacy ? API_Privacy_APP : API_Membership_APP,
      withAuthentication: true,
      cancelToken: cancelToken,
    );
  }
}
