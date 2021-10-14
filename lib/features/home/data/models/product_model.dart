class ProductModel {
  final String image;
  final String rateAvg;
  final String type;
  final String title;
  final String colorCountAvailable;
  final String price;
  final bool isLenses;
  bool isFavorite;
  ProductModel(
      {required this.title,
      required this.image,
      required this.price,
      required this.type,
      required this.colorCountAvailable,
      required this.isFavorite,
      required this.rateAvg,
      required this.isLenses});
}
