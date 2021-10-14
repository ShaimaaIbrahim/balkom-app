import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/presentation/pages/product_list_page.dart';
import 'package:ojos_app/features/product/presentation/args/product_list_args.dart';
import 'package:ojos_app/core/constants.dart';

class ItemSection extends StatefulWidget {
  final CategoryEntity? category;
  final double? width;
  final double? height;

  const ItemSection({this.category, this.width, this.height});

  @override
  _ItemSectionState createState() => _ItemSectionState();
}

class _ItemSectionState extends State<ItemSection> {
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
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                      color: globalColor.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(width! * .88),
                      border: Border.all(
                          width: 0.5,
                          color: globalColor.grey.withOpacity(0.4))),
                  padding: const EdgeInsets.all(EdgeMargin.sub),
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
                  widget.category!.name!,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  style:
                      textStyle.smallTSBasic.copyWith(color: globalColor.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
