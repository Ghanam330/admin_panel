import 'package:admin_panel/screens/product_view/widget/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product View'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              shrinkWrap: true,
              primary: false,
              itemCount: appProvider.getProductsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                  crossAxisCount: 2),
              itemBuilder: (ctx, index) {
                ProductModel singleProduct = appProvider.getProductsList[index];
                return SingleProductView(
                  singleProduct: singleProduct,
                );
              }),
        ),
      ),
    );
  }
}
