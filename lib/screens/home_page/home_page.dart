import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/categories_view/categories_view.dart';
import 'package:admin_panel/screens/home_page/widget/single_dash_item.dart';
import 'package:admin_panel/screens/order_list/ordder_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../product_view/product_view.dart';
import '../user_view/user_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  void callBackFun() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<AppProvider>(context, listen: false).callBackFun();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    callBackFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dashboard'),
        ),
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const Text(
                        "Ahmed Mohamed",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "yghanam334455@gmail.com",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GridView.count(
                        padding: const EdgeInsets.only(top: 12),
                        shrinkWrap: true,
                        primary: false,
                        crossAxisCount: 2,
                        children: [
                          SingleDashItem(
                              onTap: () {
                                Routes.instance.push(
                                    widget: const UserView(), context: context);
                              },
                              subtitle: "Users",
                              title: appProvider.userList.length.toString()),
                          SingleDashItem(
                            subtitle: "Categories",
                            title:
                                appProvider.getCategoriesList.length.toString(),
                            onTap: () {
                              Routes.instance.push(
                                  widget: const CategoriesScreen(),
                                  context: context);
                            },
                          ),
                          SingleDashItem(
                            subtitle: "Products",
                            title:
                                appProvider.getProductsList.length.toString(),
                            onTap: () {
                              Routes.instance.push(
                                  widget: const ProductView(),
                                  context: context);
                            },
                          ),
                          SingleDashItem(
                            subtitle: "Earning",
                            title: "${appProvider.getTotalEarning}",
                            onTap: () {},
                          ),
                          SingleDashItem(
                            subtitle: "Pending Orders",
                            title: appProvider.getPendingOrderList.length
                                .toString(),
                            onTap: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      title: "Pending"),
                                  context: context);
                            },
                          ),
                          SingleDashItem(
                            subtitle: "Delivered Orders",
                            title: appProvider.getDeliveredOrderList.length
                                .toString(),
                            onTap: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      title: "Delivered"),
                                  context: context);
                            },
                          ),
                          SingleDashItem(
                            subtitle: "Cancel Order",
                            title: appProvider.getCancelledOrderList.length
                                .toString(),
                            onTap: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      title: "Cancelled"),
                                  context: context);
                            },
                          ),
                          SingleDashItem(
                            subtitle: "Completed Orders",
                            title: appProvider.getCompletedOrderList.length
                                .toString(),
                            onTap: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      title: "Completed",),
                                  context: context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
