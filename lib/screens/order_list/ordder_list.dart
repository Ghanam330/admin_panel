import 'package:admin_panel/widgets/single_order_widget.dart';
import 'package:flutter/material.dart';

import '../../models/order_model/order_model.dart';

class OrderList extends StatelessWidget {
  List<OrderModel> orderList;
String? title;
  OrderList({super.key, required this.orderList, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:  Text("$title Order List"),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            OrderModel orderModel = orderList[index];
            return SingleOrderWidget(
                orderModel: orderModel
            );
          },
        )
    );
  }
}