


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../models/product_model/product_model.dart';
import '../../../provider/app_provider.dart';
import '../edit_product/edit_product.dart';

class SingleProductView extends StatefulWidget {
  SingleProductView({super.key,required this.singleProduct,required this.index});
  final ProductModel singleProduct;
  final int index;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Image.network(
                widget.singleProduct.image,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                widget.singleProduct.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Price:${widget.singleProduct.price}"),
            ],
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider.deleteProduct(widget.singleProduct);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading ?
                    const Center(
                      child: CircularProgressIndicator(),
                    ):
                    const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                          widget: EditProduct(
                              productModel: widget.singleProduct,
                              index: widget.index),
                          context: context);
                    },
                    child: const Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
