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
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    categoryId: json["categoryId"],
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

}