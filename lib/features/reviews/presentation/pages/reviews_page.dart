import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_list_my_product.dart';
import 'package:ojos_app/features/reviews/data/models/review_model.dart';

class ReviewPage extends StatefulWidget {
  static const routeName = '/review/pages/ReviewPage';

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<ReviewModel>? _list;
  initList() {
    _list = [
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: true,
          isNew: true,
          rate: 4.3,
          numOfRaters: 32,
          sales: '32'),
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: false,
          isNew: true,
          rate: 4.3,
          numOfRaters: 32,
          sales: '32'),
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: false,
          isNew: false,
          rate: 4,
          numOfRaters: 32,
          sales: '32'),
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: true,
          isNew: false,
          rate: 5,
          numOfRaters: 32,
          sales: '32'),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  @override
  Widget build(BuildContext context) {
    initList();
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('rated_drawer'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: Container(
            height: height,
            child: BuildListMyProductWidget(
              cancelToken: _cancelToken,
              itemWidth: width,
              params: {},
              isEnableRefresh: true,
              isEnablePagination: false,
            )));
  }

/*  _buildCoponTextWidget({
    BuildContext context,
    double width,
    double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      height: height,
      width: width,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Container(
                  width: 32,
                  height: 32,
                  color: globalColor.goldColor,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(
                      AppAssets.wallet_drawer,
                      width: 10.w,
                      color: globalColor.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'اجمالي الرصيد',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '360',
                    style: textStyle.bigTSBasic.copyWith(
                        color: globalColor.goldColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${Translations.of(context).translate('rail')}',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
                    padding: const EdgeInsets.fromLTRB(EdgeMargin.sub,
                        EdgeMargin.sub, EdgeMargin.sub, EdgeMargin.sub),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          'طرق الدفع',
                          style: textStyle.minTSBasic.copyWith(
                            color: globalColor.black,
                          ),
                        ),
                        Icon(
                          utils.getLang()=='ar' ? MaterialIcons.keyboard_arrow_left : MaterialIcons.keyboard_arrow_right,
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
    );
  }

  _buildPayMethodTextWidget({
    BuildContext context,
    double width,
    double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      padding: const EdgeInsets.only(
        left: EdgeMargin.subMin,
        right: EdgeMargin.subMin,
      ),
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              'شحن رصيد بالمحفظة',
              style: textStyle.smallTSBasic.copyWith(
                  color: globalColor.black, fontWeight: FontWeight.w600),
            ),
          ),
          Icon(
            utils.getLang()=='ar' ? MaterialIcons.keyboard_arrow_left : MaterialIcons.keyboard_arrow_right,
            color: globalColor.black,
          ),
        ],
      ),
    );
  }

  _buildProcessOnWalletList({BuildContext context, double width, double height}) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: EdgeMargin.small, right: EdgeMargin.small),
            child: TitleWithViewAllWidget(
              width: width,
              style: textStyle.smallTSBasic.copyWith(
                color: globalColor.black,
                fontWeight: FontWeight.w600
              ),
              title: Translations.of(context).translate('latest_wallet_operations'),
              onClickView: () {},
              strViewAll: Translations.of(context).translate('view_all'),
            ),
          ),

          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context,index){
                return Container(
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.min, right: EdgeMargin.min),
                  child: Card(
                    color: globalColor.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0.w))
                      ),
                    child:  Container(
                      width: width,
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min,bottom:EdgeMargin.min,top: EdgeMargin.min ),
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
                                  child: SvgPicture.asset(
                                    AppAssets.wallet_drawer,
                                    width: 10.w,
                                    color: globalColor.black,
                                  ),
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
                                  'شراء نظارة كلاس اصلية',
                                  style: textStyle.smallTSBasic.copyWith(
                                      color: globalColor.black, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,maxLines: 1,
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,maxLines: 1,
                                  text:  TextSpan(
                                    text: 'تم إضافة مبلغ',
                                    style: textStyle.minTSBasic.copyWith(
                                        color: globalColor.black),
                                    children: <
                                        TextSpan>[
                                      new TextSpan(
                                          text: '  500 ${Translations.of(context).translate('rail')}',
                                          style: textStyle.minTSBasic.copyWith(
                                              color: globalColor
                                                  .primaryColor,
                                          fontWeight: FontWeight.w600
                                          )),
                                      new TextSpan(
                                          text: ' لحسابك ',
                                          style: textStyle.minTSBasic.copyWith(
                                              color: globalColor
                                                  .black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: globalColor.white,
                                    borderRadius: BorderRadius.circular(12.0.w),
                                    border: Border.all(
                                        color: globalColor.grey.withOpacity(0.3),
                                        width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(EdgeMargin.sub,
                                      EdgeMargin.sub, EdgeMargin.sub, EdgeMargin.sub),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        'عرض',
                                        style: textStyle.minTSBasic.copyWith(
                                          color: globalColor.black,
                                        ),
                                      ),
                                      Icon(
                                        utils.getLang()=='ar' ? MaterialIcons.keyboard_arrow_left : MaterialIcons.keyboard_arrow_right,
                                        color: globalColor.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )


                  ),
                );
              },
            ) ,
          ),
        ],
      ),
    );
  }*/

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
