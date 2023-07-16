import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.isFavourite,
      required this.categoryId,
      this.qty});

  String image;
  String id, categoryId;
  bool isFavourite;
  String name;
  double price;
  String description;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"].toString(),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["categoryId"] ?? "",
        isFavourite: false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "categoryId": categoryId,
        "description": description,
        "isFavourite": isFavourite,
        "price": price,
        "qty": qty
      };

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? price,
    String? categoryId,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        isFavourite: false,
        qty: 1,
        price: price != null ? double.parse(price) : this.price,
        categoryId: categoryId ?? this.categoryId,
      );
}
