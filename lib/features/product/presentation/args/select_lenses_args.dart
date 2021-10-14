import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/features/product/domin/entities/general_item_entity.dart';
import 'package:ojos_app/features/product/presentation/widgets/lens_select_ipd_add_widget.dart';
import 'package:ojos_app/features/product/presentation/widgets/lens_select_size_widget.dart';
import 'package:ojos_app/features/product/presentation/widgets/select_lenses_page.dart';

class SelectLensesArgs {
  final LensesSelectedEnum? sizeForRightEye;
  final LensesSelectedEnum? sizeForLeftEye;
  final LensesIpdAddEnum? lensSize;
  final TypeOfLensesChoose? type;
  final BrandEntity? companyLenses;
  final GeneralItemEntity? colorSelect;

  const SelectLensesArgs(
      {this.type,
      this.lensSize,
      this.sizeForLeftEye,
      this.sizeForRightEye,
      this.colorSelect,
      this.companyLenses});
}
