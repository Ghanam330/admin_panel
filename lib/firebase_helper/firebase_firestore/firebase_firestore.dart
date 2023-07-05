// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:admin_panel/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../constants/constant.dart';
import '../../models/category_model/category_model.dart';
import '../../models/order_model/order_model.dart';
import '../../models/product_model/product_model.dart';
import '../../models/user_model/user_model.dart';


class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<List<UserModel>>getUserList()async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await _firebaseFirestore.collection("users").get();
      List<UserModel>userModelList = querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
      return userModelList;
    }catch(e){
      showMessage(e.toString());
      return [];
    }
  }



  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteUser(String id)async{
    try{
      _firebaseFirestore.collection("users").doc(id).delete();
      return "User Deleted Successfully";
    }catch(e){
      showMessage(e.toString());
      return "Error";
    }
  }

  Future<String>deleteCategory(String id)async{
    try{
      _firebaseFirestore.collection("categories").doc(id).delete();
      return "Category Deleted Successfully";
    }catch(e){
      showMessage(e.toString());
      return "Error";
    }
  }

  Future<void> updateSingleCategory(CategoryModel categoryModel)async{
    try{
      _firebaseFirestore.collection("categories")
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
      showMessage("Category Updated Successfully");
    }catch(e){
      showMessage(e.toString());
    }
  }

  Future<CategoryModel> addSingleCategory(File image, String name)async{

      CollectionReference collectionReference = _firebaseFirestore.collection("categories");
      String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(image);

       CategoryModel categoryModel1 = CategoryModel(
         id: collectionReference.id,
         name: name,
         image: imageUrl,
       );
     await collectionReference.add(categoryModel1.toJson());
      showMessage("Category add Successfully");
      return categoryModel1;
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
  // Future<List<ProductModel>> getBestProducts() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore.collectionGroup("products").get();
  //
  //     List<ProductModel> productModelList = querySnapshot.docs
  //         .map((e) => ProductModel.fromJson(e.data()))
  //         .toList();
  //
  //     return productModelList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }
  //
  // Future<List<ProductModel>> getCategoryViewProduct(String id) async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore
  //             .collection("categories")
  //             .doc(id)
  //             .collection("products")
  //             .get();
  //
  //     List<ProductModel> productModelList = querySnapshot.docs
  //         .map((e) => ProductModel.fromJson(e.data()))
  //         .toList();
  //
  //     return productModelList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }
  //
  // Future<UserModel> getUserInformation() async {
  //   DocumentSnapshot<Map<String, dynamic>> querySnapshot =
  //       await _firebaseFirestore
  //           .collection("users")
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .get();
  //
  //   return UserModel.fromJson(querySnapshot.data()!);
  // }
  // Future<bool> uploadOrderedProductFirebase(
  //     List<ProductModel> list, BuildContext context, String payment) async {
  //   try {
  //     showLoaderDialog(context);
  //     double totalPrice = 0.0;
  //     for (var element in list) {
  //       totalPrice += element.price * element.qty!;
  //     }
  //     DocumentReference documentReference = _firebaseFirestore
  //         .collection("usersOrders")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("orders")
  //         .doc();
  //     DocumentReference admin = _firebaseFirestore.collection("orders").doc();
  //
  //     admin.set({
  //       "products": list.map((e) => e.toJson()),
  //       "status": "Pending",
  //       "totalPrice": totalPrice,
  //       "payment": payment,
  //       "orderId": admin.id,
  //       "userId": FirebaseAuth.instance.currentUser!.uid,
  //       "userEmail": FirebaseAuth.instance.currentUser!.email,
  //       "userPhone": getUserInformation.phone,
  //     });
  //     documentReference.set({
  //       "products": list.map((e) => e.toJson()),
  //       "status": "Pending",
  //       "totalPrice": totalPrice,
  //       "payment": payment,
  //       "orderId": documentReference.id,
  //       "userId": FirebaseAuth.instance.currentUser!.uid,
  //       "userEmail": FirebaseAuth.instance.currentUser!.email,
  //       "userPhone": getUserInformation.phone,
  //     });
  //     Navigator.of(context, rootNavigator: true).pop();
  //     showMessage("Ordered Successfully");
  //     return true;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     Navigator.of(context, rootNavigator: true).pop();
  //     return false;
  //   }
  // }

  // Future<List<OrderModel>> getUserOrder() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore
  //             .collection("usersOrders")
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection("orders")
  //             .get();
  //
  //     List<OrderModel> orderList = querySnapshot.docs
  //         .map((element) => OrderModel.fromJson(element.data()))
  //         .toList();
  //
  //     return orderList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }
  //
  // void updateTokenFromFirebase() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   if (token != null) {
  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       "notificationToken": token,
  //     });
  //   }
  // }
}
