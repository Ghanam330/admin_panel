import 'package:admin_panel/widgets/single_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order_model/order_model.dart';
import '../../provider/app_provider.dart';

class OrderList extends StatelessWidget {

  String? title;

  OrderList({super.key ,this.title});

  List<OrderModel> getOrdersList(AppProvider appProvider) {
    if (title == "Pending") {
      return appProvider.getPendingOrderList;
    } else if (title == "Completed") {
      return appProvider.getCompletedOrderList;
    } else if (title == "Cancel") {
      return appProvider.getCancelledOrderList;
    } else if (title == "Delivery") {
      return appProvider.getDeliveredOrderList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("$title Order List"),
        ),
        body: getOrdersList(appProvider).isEmpty
            ? Center(
                child: Text("$title is empty"),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: getOrdersList(appProvider).length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = getOrdersList(appProvider)[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleOrderWidget(orderModel: orderModel),
                  );
                },
              ));
  }
}
