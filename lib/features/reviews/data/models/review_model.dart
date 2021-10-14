class ReviewModel {
  final String? image;
  final String? title;
  final bool? isLensesFree;
  final bool? isNew;
  final String? gender;
  final String? sales;
  final String? comment;
  final double? rate;
  final int? numOfRaters;
  const ReviewModel({
    this.title,
    this.image,
    this.sales,
    this.rate,
    this.isNew,
    this.gender,
    this.comment,
    this.isLensesFree,
    this.numOfRaters,
  });
}
