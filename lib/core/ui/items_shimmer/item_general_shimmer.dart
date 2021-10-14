import 'dart:math';

import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemGeneralShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isFromHome;
  const ItemGeneralShimmer(
      {required this.width, required this.height, this.isFromHome = false});
  @override
  State<StatefulWidget> createState() {
    return _ItemGeneralShimmerState();
  }
}

class _ItemGeneralShimmerState extends State<ItemGeneralShimmer> {
  int? randomWidth;

  int? randomWidth2;

  int? randomWidth3;

  int? randomHeight;

  int? randomHeight2;

  int? randomHeight3;

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    var rand = new Random();
    int next(int min, int max) => min + rand.nextInt(max - min);

    // Printing Random Number between 1 to 100 on Terminal Window.
    setState(() {
      randomWidth = next(60, 200);
      randomWidth2 = next(20, 60);
      randomWidth3 = next(20, 60);
      randomHeight = next(8, 25);
      randomHeight2 = next(6, 12);
      randomHeight3 = next(6, 15);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthC = widget.width ?? globalSize.setWidthPercentage(40, context);
    double heightC =
        widget.height ?? globalSize.setHeightPercentage(60, context);

    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Container(
        width: widthC,
        height: heightC,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
          child: Container(
              width: widthC,
              height: heightC,
              child: BaseShimmerWidget(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: heightC,
                          decoration: BoxDecoration(
                              color: globalColor.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0.w)),
                              border: Border.all(
                                  width: 0.5,
                                  color: globalColor.grey.withOpacity(0.3))),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: randomWidth!.toDouble(),
                                            height: 6.0,
                                            color: Colors.white,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Container(
                                            width: randomWidth!.toDouble(),
                                            height: 6.0,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: 10.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              !widget.isFromHome
                                  ? Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: 20.0,
                                              decoration: BoxDecoration(
                                                  color: globalColor.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: .5,
                                                      color: globalColor.grey
                                                          .withOpacity(0.3))),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              width: 20.0,
                                              // height: 20.0,
                                              decoration: BoxDecoration(
                                                  color: globalColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0.w),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: globalColor.grey
                                                          .withOpacity(0.3))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
