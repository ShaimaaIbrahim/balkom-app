import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ojos_app/core/datasources/remote_data_source.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/models/brand_model.dart';
import 'package:ojos_app/core/models/category_model.dart';
import 'package:ojos_app/core/models/extra_glasses_model.dart';
import 'package:ojos_app/core/models/faqs_model.dart';
import 'package:ojos_app/core/models/notifications_model.dart';
import 'package:ojos_app/core/models/offer_model.dart';
import 'package:ojos_app/core/models/shipping_carriers_model.dart';
import 'package:ojos_app/core/models/wallet_transactions_model.dart';
import 'package:ojos_app/features/cart/data/models/payment_method_model.dart';
import 'package:ojos_app/features/order/data/models/city_order_model.dart';
import 'package:ojos_app/features/others/data/models/about_app_result_model.dart';
import 'package:ojos_app/features/others/data/models/privacy_app_result_model.dart';

abstract class CoreRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, Object>> changeAppLanguage({
    required String lang,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, ExtraGlassesModel>> fetchExtraGlasses({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, OfferModel>> fetchOffers({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<CategoryModel>>> fetchCategories({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<ShippingCarriersModel>>> fetchShippingCarriers({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<CityOrderModel>>> fetchCities({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<PaymentMethodModel>>> fetchPaymentMethods({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<BrandModel>>> fetchBrands({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<NotificationsModel>>> getNotifications({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<FaqsModel>>> getFAQS({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, List<WalletTransactionsModel>>>
      getWalletTransactions({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> contactUs({
    required String name,
    required String phone,
    required String message,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> complaint({
    required String name,
    required String phone,
    required String message,
    required String email,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> setNotification({
    required bool notify_new_product,
    required bool notify_wallet,
    required bool notify_offer,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> deleteNotification({
    required String id,
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, AboutAppResultModel>> fetchAboutApp({
    required CancelToken cancelToken,
  });

  Future<Either<BaseError, PrivacyAppResultModel>> fetchPrivacyApp({
    required bool isPrivacy,
    required CancelToken cancelToken,
  });
}
