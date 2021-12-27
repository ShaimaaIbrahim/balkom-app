import 'package:dio/dio.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/entities/faqs_entity.dart';
import 'package:ojos_app/core/entities/notifications_entity.dart';
import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/entities/shipping_carriers_entity.dart';
import 'package:ojos_app/core/entities/wallet_transactions_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/repositories/repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/cart/domin/entities/payment_method_entity.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';
import 'package:ojos_app/features/others/domain/entity/privacy_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoreRepository extends Repository {
  static SharedPreferences? prefs;

  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Result<BaseError, Object>> changeAppLanguage({
    required String lang,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, ExtraGlassesEntity>> getExtraGlasses({
    // int pagesize,
    // int page,
    // Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, OfferEntity>> getOffers({
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<CategoryEntity>>> getCategories({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<ShippingCarriersEntity>>> getShippingCarriers({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<CityOrderEntity>>> getCities({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<PaymentMethodEntity>>> getPaymentMethods({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<BrandEntity>>> getBrands({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<NotificationsEntity>>> getNotifications({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<FaqsEntity>>> getFAQS({
    int? pagesize,
    int? page,
    Map<String, String>? filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, List<WalletTransactionsEntity>>>
      getWalletTransactions({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> contactUs({
    required String name,
    required String phone,
    required String message,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> complaint({
    required String name,
    required String phone,
    required String message,
    required String email,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> setNotification({
    required bool notify_new_product,
    required bool notify_wallet,
    required bool notify_offer,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> deleteNotification({
    required String id,
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, AboutAppResult>> getAboutAppInfo({
    required CancelToken cancelToken,
  });

  Future<Result<BaseError, PrivacyAppResult>> getPrivacyAppInfo({
    required bool isPrivacy,
    required CancelToken cancelToken,
  });

// static Future<void> persistExtraGlasses(ExtraGlassesModel model) async {
//   if (prefs == null) initSharedPreferences();
//   final extraGlassesJson = jsonEncode(model.toJson());
//
//   return prefs.setString(KEY_EXTRA_GLASSES, extraGlassesJson);
// }
//
//
// static Future<ExtraGlassesEntity> get cachedExtraGlasses async {
//   if (prefs == null) initSharedPreferences();
//   var extraGlassesJson = prefs.getString(KEY_EXTRA_GLASSES);
//   var extraGlasses = ExtraGlassesModel.fromJson(jsonDecode(extraGlassesJson));
//   return extraGlasses.toEntity();
//   return null;
// }

// static Future<int> get selectedGenderStyle async {
//   try{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final selectedGenderStyle =  prefs.getInt(KEY_SELECTED_GENDER_STYLE);
//     if (selectedGenderStyle != null) return selectedGenderStyle;
//     return -1111;
//   }catch(e){
//     return -1111;
//   }
//
// }
//
// static Future<bool> persistSelectedGenderStyle(int value) async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return  prefs.setInt(KEY_SELECTED_GENDER_STYLE, value);
// }

}
