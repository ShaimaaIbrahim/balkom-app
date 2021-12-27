import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/features/wallet/data/api_response/wallet_response.dart';

class WalletListItem extends StatelessWidget {
  final Data data;
  final double? width;

  const WalletListItem({Key? key, required this.data, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Image.asset(
                AppAssets.dollar,
                width: 20.w,
                height: 20.w,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.clientName!,
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '${DateFormat("yyyy-MM-dd")
                      .parse(data.createdAt!).day} / ${DateFormat("yyyy-MM-dd")
                      .parse(data.createdAt!).month} / ${DateFormat("yyyy-MM-dd")
                      .parse(data.createdAt!).year}',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                )
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '00 rs',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'out from account',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
