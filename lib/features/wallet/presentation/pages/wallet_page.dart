import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_list_wallet_transactions.dart';
import 'package:ojos_app/core/ui/widget/title_with_view_all_widget.dart';
import 'package:ojos_app/features/home/data/models/category_model.dart';
import 'package:ojos_app/features/wallet/data/api_response/wallet_response.dart';
import 'package:ojos_app/features/wallet/data/domain/services/wallet_api.dart';
import 'package:ojos_app/features/wallet/presentation/widgets/wallet_list_item.dart';

class WalletPage extends StatefulWidget {
  static const routeName = '/wallet/pages/WalletPage';

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  WalletApi _walletApi = WalletApi();
  WalletResponse? walletResponse;

  List<CategoryModel> _itemsCategory = [
    CategoryModel(
        id: 1, imageUrl: AppAssets.section_sun_glasses, title: 'نظارات شمسية'),
    CategoryModel(
        id: 2, imageUrl: AppAssets.section_med_glasses, title: 'نظارات طبيه'),
    CategoryModel(id: 3, imageUrl: AppAssets.cat_2, title: 'عدسات لاصقه'),
    CategoryModel(
        id: 4, imageUrl: AppAssets.section_box_glasses, title: 'اكسسوارات'),
    CategoryModel(id: 1, imageUrl: AppAssets.section_rmosh, title: 'رموش'),
    CategoryModel(id: 2, imageUrl: AppAssets.section_lens, title: 'عدسات'),
    CategoryModel(
        id: 1, imageUrl: AppAssets.section_sun_glasses, title: 'نظارات شمسية'),
    CategoryModel(
        id: 2, imageUrl: AppAssets.section_med_glasses, title: 'نظارات طبيه'),
    CategoryModel(id: 3, imageUrl: AppAssets.cat_2, title: 'عدسات لاصقه'),
    CategoryModel(
        id: 4, imageUrl: AppAssets.section_box_glasses, title: 'اكسسوارات'),
    CategoryModel(id: 1, imageUrl: AppAssets.section_rmosh, title: 'رموش'),
    CategoryModel(id: 2, imageUrl: AppAssets.section_lens, title: 'عدسات'),
  ];

  CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    getClientWallet();

    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('wallet_drawer'),
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
        body: walletResponse == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                //height: height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          child: ListView.separated(
                              itemCount: walletResponse!.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return WalletListItem(
                                    width: width,
                                    data: walletResponse!.data![index]);
                              }, separatorBuilder: (BuildContext context, int index) {
                                return Divider();
                          },),
                        ),
                        VerticalPadding(
                          percentage: 4.0,
                        ),
                      ],
                    ),
                  ),
                )));
  }

/*
  _buildCoponTextWidget({
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
  }*/

  _buildProcessOnWalletList(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: EdgeMargin.small, right: EdgeMargin.small),
            child: TitleWithViewAllWidget(
              width: width,
              style: textStyle.smallTSBasic.copyWith(
                  color: globalColor.black, fontWeight: FontWeight.w600),
              title: Translations.of(context)
                  .translate('latest_wallet_operations'),
              onClickView: () {},
              hideSeeAll: true,
              strViewAll: Translations.of(context).translate('view_all'),
            ),
          ),
          Container(
            child: BuildListWalletTransactionsWidget(
              isScrollList: false,
              isEnablePagination: false,
              isEnableRefresh: false,
              cancelToken: _cancelToken,
              params: {},
              itemWidth: width,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  void getClientWallet() {
    _walletApi.getClientWallet(true, null, _cancelToken).then((value) {
      setState(() {
        this.walletResponse = value;
      });
    });
  }
}
