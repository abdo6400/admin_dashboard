class Product {
  final int id;
  final String titleEn;
  final String descriptionEn;
  final String titleAr;
  final String descriptionAr;
  final String sku;
  final String productUnit;
  final double price;
  final int stock;
  final int minimumOrderQuantity;
  final double discountPercentage;
  final double rating;
  final List<String> images;

  Product({
    required this.id,
    required this.titleEn,
    required this.descriptionEn,
        required this.titleAr,
    required this.descriptionAr,
    required this.sku,
    required this.productUnit,
    required this.price,
    required this.stock,
    required this.minimumOrderQuantity,
    required this.discountPercentage,
    required this.rating,
    required this.images,
  });
}
