import 'package:ojos_app/core/entities/base_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';

class CartEntity extends BaseEntity {
   int? id;
  //final int colorId;
   ProductDetailsEntity? productEntity;
   bool? isGlasses;
  // final LensesSelectedEnum sizeForRightEye;
  // final LensesSelectedEnum sizeForLeftEye;
  // final LensesIpdAddEnum lensSize;
  // final int SizeModeId;
  // // final String ipdSize;
  //  SelectLensesArgs argsForGlasses;
  int? count;

  CartEntity({
    required this.id,
    //   @required this.colorId,
    required this.productEntity,
    required this.isGlasses,
    //  @required this.lensSize,
    //  @required this.sizeForLeftEye,
    //   @required this.sizeForRightEye,
    //   @required this.SizeModeId,
    required this.count,
    //   @required this.argsForGlasses,
  });

  @override
  List<Object> get props => [
        id!,
        //  colorId,
        productEntity!,
        isGlasses!,
        // lensSize,
        // SizeModeId,
        //     sizeForLeftEye,
        //     sizeForRightEye,
        count!,
        //argsForGlasses
      ];
}
