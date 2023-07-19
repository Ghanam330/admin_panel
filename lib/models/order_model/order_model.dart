
import '../product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.status,
    required this.userPhone,
    required this.userEmail,
  });

  String payment;
  String status;
  String? userPhone;
  String? userEmail;
  List<ProductModel> products;
  double totalPrice;
  String orderId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
        orderId: json["orderId"],
        userPhone: json["userPhone"],
        userEmail: json["userEmail"],
        products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
        totalPrice: json["totalPrice"],
        status: json["status"],
        payment: json["payment"]);
  }
}