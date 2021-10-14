import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/features/product/domin/entities/general_item_entity.dart';

class ItemColorProductDetails extends StatefulWidget {
  GeneralItemEntity? item;
  Function(GeneralItemEntity, bool)? onSelect;
  bool? isSelected;
  ItemColorProductDetails({this.item, this.onSelect, this.isSelected});
  @override
  _ItemColorFilterState createState() => _ItemColorFilterState();
}

class _ItemColorFilterState extends State<ItemColorProductDetails> {
  // bool _isSelect =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isSelect = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              // _isSelect= !_isSelect;
              if (widget.onSelect != null) {
                widget.onSelect!(widget.item!, true);
              }
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5),
          ),
          height: 35.h,
          width: 55.w,
          margin: const EdgeInsets.only(
              left: EdgeMargin.verySub,
              right: EdgeMargin.verySub,
              bottom: EdgeMargin.verySub),
          child: Padding(
            padding: const EdgeInsets.all(EdgeMargin.sub),
            child: Stack(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   //  shape: BoxShape.circle,
                  //     color: HexColor(widget.item.value)),
                  child: SvgPicture.asset(AppAssets.glasses_svg,
                      color: HexColor(widget.item!.value)),
                ),
                widget.isSelected!
                    ? Container(
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: globalColor.black.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: globalColor.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
