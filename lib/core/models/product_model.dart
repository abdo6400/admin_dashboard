import '../entities/product.dart';

class ProductModel
    extends Product {
  ProductModel({
    required super.id,
    required super.titleEn,
    required super.descriptionEn,
    required super.titleAr,
    required super.descriptionAr,
    required super.sku,
    required super.productUnit,
    required super.price,
    required super.stock,
    required super.minimumOrderQuantity,
    required super.discountPercentage,
    required super.rating,
    required super.images,
  });

  factory ProductModel.fromJson(
      Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      titleEn: json["titleEn"],
      descriptionEn: json["descriptionEn"],
      titleAr: json["titleAr"],
      descriptionAr: json["descriptionAr"],
      sku: json["sku"],
      productUnit: json["product_Unit"],
      price: double.parse(json["price"].toString()),
      stock: json["stock"],
      minimumOrderQuantity: json["minimumOrderQuantity"],
      discountPercentage: double.parse(json["discountPercentage"].toString()),
      rating: double.parse(json["rating"].toString()),
      images: List<String>.from(json["images"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titleEn": titleEn,
      "descriptionEn": descriptionEn,
      "titleAr": titleAr,
      "descriptionAr": descriptionAr,
      "sku": sku,
      "product_Unit": productUnit,
      "price": price,
      "stock": stock,
      "minimumOrderQuantity": minimumOrderQuantity,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "images": List<dynamic>.from(images.map((x) => x)),
    };
  }
}
