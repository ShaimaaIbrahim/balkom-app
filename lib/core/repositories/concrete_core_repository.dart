import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/daos/cached_categories_dao.dart';
import 'package:ojos_app/core/daos/cached_brands_dao.dart';
import 'package:ojos_app/core/daos/cached_cities_dao.dart';
import 'package:ojos_app/core/daos/cached_payment_method_dao.dart';
import 'package:ojos_app/core/daos/cached_shipping_carriers_dao.dart';
import 'package:ojos_app/core/database/db.dart';
import 'package:ojos_app/core/datasources/core_remote_data_source.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/entities/faqs_entity.dart';
import 'package:ojos_app/core/entities/notifications_entity.dart';
import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/entities/shipping_carriers_entity.dart';
import 'package:ojos_app/core/entities/wallet_transactions_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/models/category_model.dart';
import 'package:ojos_app/core/models/brand_model.dart';
import 'package:ojos_app/core/models/extra_glasses_model.dart';
import 'package:ojos_app/core/models/faqs_model.dart';
import 'package:ojos_app/core/models/notifications_model.dart';
import 'package:ojos_app/core/models/offer_model.dart';
import 'package:ojos_app/core/models/shipping_carriers_model.dart';
import 'package:ojos_app/core/models/wallet_transactions_model.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/cart/data/models/payment_method_model.dart';
import 'package:ojos_app/features/cart/domin/entities/payment_method_entity.dart';
import 'package:ojos_app/features/order/data/models/city_order_model.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';
import 'package:ojos_app/features/others/data/models/about_app_result_model.dart';
import 'package:ojos_app/features/others/data/models/privacy_app_result_model.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';
import 'package:ojos_app/features/others/domain/entity/privacy_result.dart';

class ConcreteCoreRepository extends CoreRepository {
  final CoreRemoteDataSource remoteDataSource;

  ConcreteCoreRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, Object>> changeAppLanguage({
    required String lang,
    required CancelToken cancelToken,
  }) async {
    await AppDB.clear();
    final remoteResult = await remoteDataSource.changeAppLanguage(
      lang: lang,
      cancelToken: cancelToken,
    );

    // TODO : to return to here
//    if (remoteResult.isRight()) {
//      await AppDB.clear();
//    }

    return executeForNoData(remoteResult: remoteResult);
  }

  @override
  Future<Result<BaseError, ExtraGlassesEntity>> getExtraGlasses(
      {required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchExtraGlasses(
      cancelToken: cancelToken,
    );

    // if (remoteResult.isRight()) {
    //   final data = (remoteResult as Right<BaseError, ExtraGlassesModel>).value;
    //   if (data != null && data.toEntity() != null) {
    //     await CoreRepository.persistExtraGlasses(data);
    //   }
    // }
    return execute<ExtraGlassesModel, ExtraGlassesEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, OfferEntity>> getOffers(
      {required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchOffers(
      cancelToken: cancelToken,
    );
    return execute<OfferModel, OfferEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, List<CategoryEntity>>> getCategories(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchCategories(
      cancelToken: cancelToken,
    );
    return executeForListWithCacheRemoteFirst<CategoryModel, CategoryEntity,
        CachedCategoriesDao>(
      remoteResult: remoteResult,
      dao: CachedCategoriesDao(),
    );
  }

  @override
  Future<Result<BaseError, List<ShippingCarriersEntity>>> getShippingCarriers(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchShippingCarriers(
      cancelToken: cancelToken,
    );
    return executeForListWithCacheRemoteFirst<ShippingCarriersModel,
        ShippingCarriersEntity, CachedShippingCarriersDao>(
      remoteResult: remoteResult,
      dao: CachedShippingCarriersDao(),
    );
  }

  @override
  Future<Result<BaseError, List<CityOrderEntity>>> getCities(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchCities(
      cancelToken: cancelToken,
    );
    return executeForListWithCacheRemoteFirst<CityOrderModel, CityOrderEntity,
        CachedCitiesDao>(
      remoteResult: remoteResult,
      dao: CachedCitiesDao(),
    );
  }

  @override
  Future<Result<BaseError, List<PaymentMethodEntity>>> getPaymentMethods(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchPaymentMethods(
      cancelToken: cancelToken,
    );
    return executeForListWithCacheRemoteFirst<PaymentMethodModel,
        PaymentMethodEntity, CachedPaymentMethodDao>(
      remoteResult: remoteResult,
      dao: CachedPaymentMethodDao(),
    );
  }

  @override
  Future<Result<BaseError, List<BrandEntity>>> getBrands(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchBrands(
      cancelToken: cancelToken,
    );
    return executeForListWithCacheRemoteFirst<BrandModel, BrandEntity,
        CachedBrandsDao>(
      remoteResult: remoteResult,
      dao: CachedBrandsDao(),
    );
  }

  @override
  Future<Result<BaseError, List<NotificationsEntity>>> getNotifications(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.getNotifications(
      cancelToken: cancelToken,
    );
    return executeForList<NotificationsModel, NotificationsEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, List<FaqsEntity>>> getFAQS(
      {int? pagesize,
      int? page,
      Map<String, String>? filterParams,
      required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.getFAQS(
      cancelToken: cancelToken,
    );
    return executeForList<FaqsModel, FaqsEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, List<WalletTransactionsEntity>>>
      getWalletTransactions(
          {int? pagesize,
          int? page,
          Map<String, String>? filterParams,
          required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.getWalletTransactions(
      cancelToken: cancelToken,
    );
    return executeForList<WalletTransactionsModel, WalletTransactionsEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> contactUs({
    required String name,
    required String phone,
    required String message,
    required CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.contactUs(
      message: message,
      phone: phone,
      name: name,
      cancelToken: cancelToken,
    );

    return executeForNoData(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> complaint({
    required String name,
    required String phone,
    required String message,
    required String email,
    required CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.complaint(
      message: message,
      phone: phone,
      name: name,
      email: email,
      cancelToken: cancelToken,
    );

    return executeForNoData(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> setNotification({
    required bool notify_new_product,
    required bool notify_wallet,
    required bool notify_offer,
    required CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.setNotification(
      notify_new_product: notify_new_product,
      notify_wallet: notify_wallet,
      notify_offer: notify_offer,
      cancelToken: cancelToken,
    );

    return executeForNoData(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> deleteNotification({
    required int id,
    required CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.deleteNotification(
      id: id,
      cancelToken: cancelToken,
    );

    return executeForNoData(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, AboutAppResult>> getAboutAppInfo(
      {required CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchAboutApp(
      cancelToken: cancelToken,
    );
    return execute<AboutAppResultModel, AboutAppResult>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, PrivacyAppResult>> getPrivacyAppInfo(
      {required CancelToken cancelToken, required bool isPrivacy}) async {
    final remoteResult = await remoteDataSource.fetchPrivacyApp(
        cancelToken: cancelToken, isPrivacy: isPrivacy);
    return execute<PrivacyAppResultModel, PrivacyAppResult>(
      remoteResult: remoteResult,
    );
  }
}
