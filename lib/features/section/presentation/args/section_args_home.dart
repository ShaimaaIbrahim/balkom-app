import 'package:ojos_app/features/product/domin/entities/product_entity.dart';

class SectionArgsHome {
  final List<ProductEntity> list;
  final String name;
  final int id;

  const SectionArgsHome(
      {required this.name, required this.id, required this.list});
}
