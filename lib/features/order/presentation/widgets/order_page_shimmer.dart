import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';

class OrderPageShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final String? status;

  const OrderPageShimmer({
    this.width,
    this.height,
    this.status,
  });

  @override
  _OrderPageShimmerState createState() => _OrderPageShimmerState();
}

class _OrderPageShimmerState extends State<OrderPageShimmer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.status == "new"
                ? Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.only(
                        left: EdgeMargin.min, right: EdgeMargin.min),
                    child: Text(
                      Translations.of(context).translate('order_tracking'),
                      style: textStyle.smallTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : Container(),
            widget.status == "new"
                ? Container(
                    margin: const EdgeInsets.only(
                      left: EdgeMargin.min,
                      right: EdgeMargin.min,
                    ),
                    height: widget.height! * .16,
                    child: _buildStepShimmerWidget(
                        context: context, width: widget.width!))
                : Container(),
            Container(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _itemShimmer(width: widget.width!);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  _buildStepShimmerWidget({required BuildContext context, required double width}) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child:  BaseShimmerWidget(
              child: Container(
                width: 73.w,
                height: 60,
                decoration: BoxDecoration(
                    color: globalColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.2), width: 1.0)),
              ),
            ),
          ),
          Expanded(
              child: Container(
                height: 1.0,
                color: globalColor.primaryColor,
              )),
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child:  BaseShimmerWidget(
              child: Container(
                width: 73.w,
                height: 60,
                decoration: BoxDecoration(
                    color: globalColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.2), width: 1.0)),
              ),
            ),
          ),
          Expanded(
              child: Container(
                height: 1.0,
                color: globalColor.grey.withOpacity(0.2),
              )),
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child:  BaseShimmerWidget(
              child: Container(
                width: 73.w,
                height: 60,
                decoration: BoxDecoration(
                    color: globalColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.2), width: 1.0)),
              ),
            ),
          ),
          Expanded(
              child: Container(
                height: 1.0,
                color: globalColor.grey.withOpacity(0.2),
              )),
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child:  BaseShimmerWidget(
              child: Container(
                width: 73.w,
                height: 60,
                decoration: BoxDecoration(
                    color: globalColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.2), width: 1.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _itemShimmer({required double width}) {
    return Container(
      width: width,
      padding:
          EdgeInsets.only(left: EdgeMargin.subMin, right: EdgeMargin.subMin),
      child: Card(
        color: globalColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.subMin,
                      right: EdgeMargin.subMin,
                      bottom: EdgeMargin.subMin,
                      top: EdgeMargin.subMin),
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        height: 144.h,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 144.h,
                                    child: BaseShimmerWidget(
                                      child: Container(
                                        width: 10.w,
                                        height: 144.h,
                                        decoration: BoxDecoration(
                                          color: globalColor.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.w)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Positioned(
                            //   bottom: 4.0,
                            //   right: 4.0,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       color: globalColor.white,
                            //       borderRadius:
                            //       BorderRadius.circular(12.0.w),
                            //     ),
                            //
                            //     constraints: BoxConstraints(
                            //         minWidth: width * .1),
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(
                            //           left: 4.0, right: 4.0),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.center,
                            //         children: [
                            //           SizedBox(
                            //             width: 2,
                            //           ),
                            //           BaseShimmerWidget(
                            //             child: Container(
                            //               width: 16,
                            //               height: 16,
                            //               color: Colors.white,
                            //
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: 4,
                            //           ),
                            //           BaseShimmerWidget(
                            //             child: Container(
                            //               width: 40,
                            //               height: 8,
                            //               color: Colors.white,
                            //
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 4.0,
                            //   top: 4.0,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         decoration: BoxDecoration(
                            //           color: globalColor.white,
                            //           borderRadius:
                            //           BorderRadius.circular(12.0.w),
                            //         ),
                            //         height: 20.h,
                            //         constraints: BoxConstraints(
                            //             minWidth: width * .09),
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: EdgeMargin.verySub,
                            //               right: EdgeMargin.verySub),
                            //           child:BaseShimmerWidget(
                            //             child: Container(
                            //               width: 16,
                            //               height: 6,
                            //               color: Colors.white,
                            //
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         width: 5.0,
                            //       ),
                            //       true
                            //           ? Container(
                            //         decoration: BoxDecoration(
                            //           color: globalColor
                            //               .primaryColor,
                            //           borderRadius:
                            //           BorderRadius.circular(
                            //               12.0.w),
                            //         ),
                            //         height: 20.h,
                            //         constraints: BoxConstraints(
                            //             minWidth: width * .15),
                            //         child: Padding(
                            //           padding:
                            //           const EdgeInsets.only(
                            //               left: EdgeMargin
                            //                   .verySub,
                            //               right: EdgeMargin
                            //                   .verySub),
                            //           child: BaseShimmerWidget(
                            //             child: Container(
                            //               width: 16,
                            //               height: 6,
                            //               color: Colors.white,
                            //
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //           : Container(
                            //         child: Text(''),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BaseShimmerWidget(
                                      child: Container(
                                        width: 60,
                                        height: 6,
                                        color: Colors.white,
                                      ),
                                    ),
                                    VerticalPadding(
                                      percentage: 1.0,
                                    ),
                                    Container(
                                      child: BaseShimmerWidget(
                                        child: Container(
                                          width: 35,
                                          height: 6,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              alignment: AlignmentDirectional.centerEnd,
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.verySub,
                                  EdgeMargin.sub,
                                  EdgeMargin.verySub,
                                  EdgeMargin.sub),
                              child: FittedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0, right: 4.0),
                                        child: BaseShimmerWidget(
                                          child: Container(
                                            width: 16,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: globalColor.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.w)),
                                                border: Border.all(
                                                    color: globalColor.grey
                                                        .withOpacity(0.3),
                                                    width: 0.5)),
                                            constraints: BoxConstraints(
                                                minWidth: width * .1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: BaseShimmerWidget(
                                        child: Container(
                                          width: 20,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: globalColor.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.w)),
                                              border: Border.all(
                                                  color: globalColor.grey
                                                      .withOpacity(0.3),
                                                  width: 0.5)),
                                          padding: const EdgeInsets.fromLTRB(
                                              EdgeMargin.subSubMin,
                                              EdgeMargin.verySub,
                                              EdgeMargin.subSubMin,
                                              EdgeMargin.verySub),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: globalColor.backgroundLightPrim,
                  height: 2.0,
                ),
                Container(
                  //padding: const EdgeInsets.all(EdgeMargin.subMin),
                  height: 41.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          HorizontalPadding(
                            percentage: 3,
                          ),
                          BaseShimmerWidget(
                            child: Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //margin: const EdgeInsets.only(left:EdgeMargin.min,right: EdgeMargin.min),
                        width: 148.w,
                        height: 41.h,
                        color: globalColor.scaffoldBackGroundGreyColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: BaseShimmerWidget(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: globalColor.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              globalColor.grey.withOpacity(0.2),
                                          width: 1.0)),
                                  width: 12.w,
                                  height: 12.w,
                                ),
                              ),
                            ),
                            HorizontalPadding(
                              percentage: 1,
                            ),
                            BaseShimmerWidget(
                              child: Container(
                                width: 16,
                                height: 6,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: globalColor.backgroundLightPrim,
                  height: 2.0,
                ),
                Container(
                  //padding: const EdgeInsets.all(EdgeMargin.subMin),
                  height: 41.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          HorizontalPadding(
                            percentage: 3,
                          ),
                          BaseShimmerWidget(
                            child: Container(
                              width: 60,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //margin: const EdgeInsets.only(left:EdgeMargin.min,right: EdgeMargin.min),
                        width: 148.w,
                        height: 41.h,
                        color: globalColor.scaffoldBackGroundGreyColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HorizontalPadding(
                              percentage: 1,
                            ),
                            BaseShimmerWidget(
                              child: Container(
                                width: 40,
                                height: 6,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
