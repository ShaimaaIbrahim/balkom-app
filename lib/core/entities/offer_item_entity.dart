import 'base_entity.dart';

class OfferItemEntity extends BaseEntity {
  final int? id;
  final String? name;
  final String? image;
  final String? info;
  final int? discountPrice;
  final String? discountType;
  final int? discountTypeInt;
  final int? productId;
  final String? type;
  final bool? is_glasses;

  OfferItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.is_glasses,
    required this.discountPrice,
    required this.discountType,
    required this.discountTypeInt,
    required this.info,
    required this.productId,
  });

  @override
  List<Object> get props => [
        id ?? '',
        name ?? '',
        image ?? '',
        type ?? '',
        discountPrice ?? '',
        discountType ?? '',
        discountTypeInt ?? '',
        info ?? '',
        productId ?? '',
        is_glasses ?? '',
      ];
}
