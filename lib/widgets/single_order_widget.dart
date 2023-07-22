import 'package:admin_panel/constants/constant.dart';
import 'package:admin_panel/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:admin_panel/models/order_model/order_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleOrderWidget extends StatefulWidget {
  OrderModel orderModel;

  SingleOrderWidget({super.key, required this.orderModel});

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        collapsedShape: RoundedRectangleBorder(
            side:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.3)),
        shape: RoundedRectangleBorder(
            side:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.3)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              height: 120,
              width: 120,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              child: Image.network(
                widget.orderModel.products[0].image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.orderModel.products[0].name,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Phone User: ${widget.orderModel.userPhone.toString()}",
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  widget.orderModel.products.length > 1
                      ? SizedBox.fromSize()
                      : Column(
                          children: [
                            Text(
                              "Quanity: ${widget.orderModel.products[0].qty.toString()}",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            // Text(
                            //   "Phone User: ${orderModel.userPhone.toString()}",
                            //   style: const TextStyle(
                            //     fontSize: 12.0,
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 12.0,
                            // ),
                          ],
                        ),
                  Text(
                    "Total Price: \$${widget.orderModel.totalPrice.toString()}",
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Order Status: ${widget.orderModel.status}",
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  widget.orderModel.status == "Pending"
                      ? CupertinoButton(
                          onPressed: () async {
                            await FirebaseFirestoreHelper.instance
                                .updateOrder(widget.orderModel, "Delivery");
                            widget.orderModel.status = "Delivery";
                            appProvider.getPendingOrderList
                                .remove(widget.orderModel);
                            appProvider.updatePendingOrder(widget.orderModel);
                            setState(() {});
                          },
                          child: Container(
                            height: 48,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text("Send to Delivery",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                )),
                          ))
                      : SizedBox.fromSize(),
                  widget.orderModel.status == "Pending" ||
                          widget.orderModel.status == "Delivery"
                      ? CupertinoButton(
                          onPressed: ()async {
                            if (widget.orderModel.status == "Pending") {
                              widget.orderModel.status == "Cancel";
                              await FirebaseFirestoreHelper.instance
                                  .updateOrder(widget.orderModel, "Cancel");
                              appProvider
                                  .updateCancelPendingOrder(widget.orderModel);
                            }else{
                              widget.orderModel.status == "Cancel";
                              await FirebaseFirestoreHelper.instance
                                  .updateOrder(widget.orderModel, "Cancel");
                              appProvider
                                  .updateCancelDeliveryOrder(widget.orderModel);
                            }
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 48,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text("Cancel Order",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                )),
                          ))
                      : SizedBox.fromSize(),
                ],
              ),
            ),
          ],
        ),
        children: widget.orderModel.products.length > 1
            ? [
                const Text("Details"),
                Divider(color: Theme.of(context).primaryColor),
                ...widget.orderModel.products.map((singleProduct) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              child: Image.network(
                                singleProduct.image,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    singleProduct.name,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Quanity: ${singleProduct.qty.toString()}",
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Price: \$${singleProduct.price.toString()}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Theme.of(context).primaryColor),
                      ],
                    ),
                  );
                }).toList()
              ]
            : [],
      ),
    );
  }
}
