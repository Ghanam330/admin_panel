import 'package:flutter/material.dart';

import '../../models/order_model/order_model.dart';

class OrderList extends StatelessWidget {
  List<OrderModel> orderList;
   OrderList({super.key, required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Completed Order List'),
      ),

      body:ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {

          return Card(
            child:
          );
        },
      )
    );
  }
}
