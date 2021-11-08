import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/entities/notifications_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/ui/dailog/confirm_dialog.dart';
import 'package:ojos_app/core/ui/dailog/soon_dailog.dart';
import 'package:ojos_app/core/usecases/delete_notifications.dart';
import 'package:ojos_app/features/brand/presentation/pages/brand_page.dart';
import 'package:ojos_app/features/home/presentation/pages/home_page.dart';
import 'package:ojos_app/features/notification/data/models/notification_model.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/order/presentation/pages/my_order_page.dart';
import 'package:ojos_app/features/others/presentation/pages/favorite_page.dart';
import 'package:ojos_app/features/others/presentation/pages/offers_page.dart';
import 'package:ojos_app/features/others/presentation/pages/sub_pages/contact_us_page.dart';
import 'package:ojos_app/features/profile/presentation/pages/profile_page.dart';
import 'package:ojos_app/features/reviews/presentation/pages/reviews_page.dart';
import 'package:ojos_app/features/section/presentation/pages/section_page.dart';
import '../../../../main.dart';

class ItemNotificationWidget extends StatelessWidget {
  final double? width;
  final NotificationsEntity? notification;
  final CancelToken? cancelToken;
  final Function? onUpdate;

  const ItemNotificationWidget(
      {this.width, this.notification, this.cancelToken, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
      child: Card(
          color: globalColor.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
          child: Container(
            width: width,
            padding: const EdgeInsets.only(
                left: EdgeMargin.min,
                right: EdgeMargin.min,
                bottom: EdgeMargin.min,
                top: EdgeMargin.min),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Center(
                    child: Container(
                      width: 32,
                      height: 32,
                      color: globalColor.scaffoldBackGroundGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: notification!.type_int != 10
                            ? SvgPicture.asset(
                                _getImage(notification!.type_int ?? 0),
                                width: 10.w,
                                color: globalColor.black,
                              )
                            : Image.network(notification!.icon!),
                      ),
                    ),
                  ),
                ),
                HorizontalPadding(
                  percentage: 2.5,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        notification!.title ?? 'اهلا',
                        style: textStyle.smallTSBasic.copyWith(
                            color: globalColor.black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        notification!.description ?? 'اهلا بك رسالة ترحيبية',
                        style: textStyle.minTSBasic.copyWith(
                            color: globalColor.black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => ConfirmDialog(
                              title:
                                  Translations.of(context).translate('delete'),
                              confirmMessage: Translations.of(context)
                                  .translate('are_you_sure_delete'),
                              actionYes: () {
                                Get.Get.back();
                                _requestDeleteNotificationsNewProduct(
                                    id: notification!.id!, context: context);
                              },
                              actionNo: () {
                                Get.Get.back();
                              },
                            ),
                          );
                        },
                        child: Container(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: globalColor.white,
                                  borderRadius: BorderRadius.circular(12.0.w),
                                  border: Border.all(
                                      color: globalColor.grey.withOpacity(0.3),
                                      width: 0.5)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    EdgeMargin.sub,
                                    EdgeMargin.sub,
                                    EdgeMargin.sub,
                                    EdgeMargin.sub),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: globalColor.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalPadding(
                        percentage: 1.5,
                      ),
                      InkWell(
                        onTap: () {
                          _onPress(
                              _getType(notification!.type_int ?? 1), context);
                        },
                        child: Container(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: globalColor.white,
                                  borderRadius: BorderRadius.circular(12.0.w),
                                  border: Border.all(
                                      color: globalColor.grey.withOpacity(0.3),
                                      width: 0.5)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    EdgeMargin.sub,
                                    EdgeMargin.sub,
                                    EdgeMargin.sub,
                                    EdgeMargin.sub),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      Translations.of(context)
                                          .translate('view'),
                                      style: textStyle.minTSBasic.copyWith(
                                        color: globalColor.black,
                                      ),
                                    ),
                                    Icon(
                                      utils.getLang() == 'ar'
                                          ? Icons.keyboard_arrow_left
                                          : Icons.keyboard_arrow_right,
                                      color: globalColor.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _requestDeleteNotificationsNewProduct(
      {required String id, required BuildContext context}) async {
    final result = await DeleteNotificationUseCase(locator<CoreRepository>())(
      DeleteNotificationParams(cancelToken: cancelToken!, id: id),
    );
    if (result.hasDataOnly) {
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('Deleted'),
          backgroundColor: globalColor.primaryColor,
          textColor: globalColor.white);

      if (onUpdate != null) onUpdate!();
    } else if (result.hasErrorOnly || result.hasDataAndError)
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('err_unexpected'));
  }

  // 0=orders
  // 1=profile
  // 2=favorite
  // 3=devison
  // 4=wallet
  // 5=review
  // 6=offers
  // 7=messages
  // 8=subport
  // 9=brand

  _getImage(int type) {
    switch (type) {
      case 0:
        return AppAssets.order_drawer;
        break;

      case 1:
        return AppAssets.profile_nav_bar;
        break;
      case 2:
        return AppAssets.love;
        break;
      case 3:
        return AppAssets.section_nav_bar;
        break;
      case 4:
        return AppAssets.wallet_drawer;
        break;
      case 5:
        return AppAssets.review_drawer;
        break;
      case 6:
        return AppAssets.sales_svg;
        break;
      case 7:
        return AppAssets.test_result_svg;
        break;
      case 8:
        return AppAssets.supported_team_svg;
        break;
      case 9:
        return AppAssets.brand_btnv_svg;
        break;
      case 10:

      default:
        return AppAssets.order_drawer;
        break;
    }
  }

  _getType(int type) {
    switch (type) {
      case 0:
        return NotificationType.order;
        break;

      case 1:
        return NotificationType.profile;
        break;
      case 2:
        return NotificationType.favorite;
        break;
      case 3:
        return NotificationType.section;
        break;
      case 4:
        return NotificationType.wallet;
        break;
      case 5:
        return NotificationType.review;
        break;
      case 6:
        return NotificationType.offer;
        break;
      case 7:
        return NotificationType.message;
        break;
      case 8:
        return NotificationType.supported_team;
        break;
      case 9:
        return NotificationType.brand;
        break;

      case 10:
        return NotificationType.product;
        break;

      case 11:
        return NotificationType.copoun;
        break;

      default:
        return NotificationType.order;
        break;
    }
  }

  _onPress(NotificationType type, BuildContext context) {
    switch (type) {
      case NotificationType.order:
        Get.Get.toNamed(MyOrderPage.routeName);
        break;
      case NotificationType.brand:
        Get.Get.toNamed(BrandPage.routeName);
        break;
      case NotificationType.supported_team:
        Get.Get.toNamed(ContactUsPage.routeName);
        break;
      case NotificationType.message:
        // TODO: Handle this case.
        break;
      case NotificationType.offer:
        Get.Get.toNamed(OffersPage.routeName);
        break;
      case NotificationType.review:
        Get.Get.toNamed(ReviewPage.routeName);
        break;
      case NotificationType.wallet:
        showDialog(
          context: context,
          builder: (ctx) => SoonDialog(),
        );
        break;
      case NotificationType.section:
        Get.Get.toNamed(SectionPage.routeName);
        break;
      case NotificationType.favorite:
        Get.Get.toNamed(FavoritePage.routeName);
        break;
      case NotificationType.profile:
        Get.Get.toNamed(ProfilePage.routeName);
        break;
      case NotificationType.product:
        Get.Get.toNamed(HomePage.routeName);
        break;
    }
  }
}

enum NotificationType {
  order,
  brand,
  supported_team,
  message,
  offer,
  review,
  wallet,
  section,
  favorite,
  profile,
  product,
  copoun
}
