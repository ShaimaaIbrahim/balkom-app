import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/core/ui/widget/normal_assets_image.dart';
import 'package:ojos_app/features/home/data/models/category_model.dart';

import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/presentation/args/product_list_args.dart';
import 'package:ojos_app/features/product/presentation/pages/product_list_page.dart';

class ItemCategory extends StatefulWidget {
  final CategoryEntity? category;
  final double? width;
  final double? height;

  const ItemCategory({this.category, this.width, this.height});

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    final height = widget.height;
    return InkWell(
      onTap: () {
        Get.Get.toNamed(ProductListPage.routeName,
            arguments: ProductListArguments(
                params: {FILTER_CATEGORY_ID: widget.category!.id.toString()}));
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    color: globalColor.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(width! * .88),
                    border: Border.all(
                        width: 1,
                        color: globalColor.primaryColor.withOpacity(0.4))),
                padding: const EdgeInsets.all(2),
                child: ImageCacheWidget(
                  imageUrl: widget.category!.image ?? '',
                  imageHeight: width * .8,
                  imageWidth: width * .8,
                  imageBorderRadius: width * .8,
                  boxFit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: width,
              child: Text(
                widget.category!.name ?? '',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: textStyle.minTSBasic.copyWith(color: globalColor.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
