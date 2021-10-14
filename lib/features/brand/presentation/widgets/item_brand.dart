import 'package:flutter/material.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/presentation/pages/product_list_page.dart';
import 'package:ojos_app/features/product/presentation/args/product_list_args.dart';

class ItemBrand extends StatefulWidget {
  final BrandEntity brand;
  final double width;
  final double height;

  const ItemBrand(
      {required this.brand, required this.width, required this.height});

  @override
  _ItemBrandState createState() => _ItemBrandState();
}

class _ItemBrandState extends State<ItemBrand> {
  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    final height = widget.height;
    return InkWell(
      onTap: () {
        Get.Get.toNamed(ProductListPage.routeName,
            arguments: ProductListArguments(
                params: {FILTER_BRAND_ID: widget.brand.id.toString()}));
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(left: 4, right: 4),
        /* decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.circular(12.w),
            border: Border.all(
                width: 0.5, color: globalColor.grey.withOpacity(0.4))),*/
        child: Column(
          children: [
            Container(
              width: width,
              height: height - 25,
              //margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: globalColor.white,
                  borderRadius: BorderRadius.circular(12.w),
                  border: Border.all(
                      width: 0.5, color: globalColor.grey.withOpacity(0.4))),
              child: ImageCacheWidget(
                imageUrl: widget.brand.image,
                imageHeight: height,
                imageWidth: width,
                imageBorderRadius: 12.w,
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.brand.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: globalColor.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
