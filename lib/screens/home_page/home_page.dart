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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  // backgroundImage: NetworkImage(
                  //   "https://scontent.fcai21-3.fna.fbcdn.net/v/t1.6435-9/118882328_10218274556368309_680680680433877888_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Z2Z3Z2Z2Z2MAX9Z2Z2Z&_nc_ht=scontent.fcai21-3.fna&oh=3b6b5b6b5b6b5b6b5b6b5b6b5b6b5b6b&oe=60D0F0C5",
                  // ),
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
                          Routes.instance
                              .push(widget: const UserView(), context: context);
                        },
                        subtitle: "Users",
                        title: appProvider.userList.length.toString()),
                    SingleDashItem(
                      subtitle: "Categories",
                      title: appProvider.getCategoriesList.length.toString(),
                      onTap: () {
                        Routes.instance.push(
                            widget: const CategoriesScreen(), context: context);
                      },
                    ),
                    SingleDashItem(
                      subtitle: "Products",
                      title: appProvider.getProductsList.length.toString(),
                      onTap: () {
                        Routes.instance.push(
                            widget: const ProductView(), context: context);
                      },
                    ),
                    SingleDashItem(
                      subtitle: "Earning",
                      title: "${appProvider.getTotalEarning}",
                      onTap: () {},
                    ),
                    SingleDashItem(
                      subtitle: "Pending Orders",
                      title: '11',
                      onTap: () {},
                    ),
                    SingleDashItem(
                      subtitle: "Completed Orders",
                      title:
                          appProvider.getCompletedOrderList.length.toString(),
                      onTap: () {
                        Routes.instance.push(
                            widget: OrderList(
                                orderList: appProvider.getCompletedOrderList),
                            context: context);
                      },
                    ),
                    SingleDashItem(
                      subtitle: "Cancel Order",
                      title: "5",
                      onTap: () {},
                    ),
                    SingleDashItem(
                      subtitle: "Delivered Orders",
                      title: "5",
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
