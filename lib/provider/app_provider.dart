// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/constant.dart';
import '../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import '../models/category_model/category_model.dart';
import '../models/product_model/product_model.dart';
import '../models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];
  List<ProductModel> _productList = [];

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
  }

  Future<void> getCategoriesFun() async {
    _categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
  }

  bool isDeleteLoading = false;

  Future<String> deleteUser(UserModel userModel) async {
    isDeleteLoading = true;
    notifyListeners();
    String message =
        await FirebaseFirestoreHelper.instance.deleteUser(userModel.id);
    await getUserListFun();
    showMessage(message);
    isDeleteLoading = false;
    notifyListeners();
    return message;
  }

  bool isDeleteCategoryLoading = false;
  Future<void> deleteCategory(CategoryModel categoryModel) async {
    isDeleteCategoryLoading = true;
    String message =
        await FirebaseFirestoreHelper.instance.deleteCategory(categoryModel.id);
    if (message == "Category Deleted Successfully") {
     _categoriesList.remove(categoryModel);
      isDeleteCategoryLoading = false;
      notifyListeners();
      showMessage(message);
    } else {
      isDeleteCategoryLoading = false;
      notifyListeners();
      showMessage(message);
    }
  }

  void updateCategoryList(int index,CategoryModel categoryModel) async {
    FirebaseFirestoreHelper.instance.updateSingleCategory(categoryModel);
    _categoriesList[index] = categoryModel;
    notifyListeners();
  }

  void addCategoryList(File image,String name) async {
    CategoryModel c = await
    FirebaseFirestoreHelper.instance.addSingleCategory(image, name);
    _categoriesList.add(c);
    notifyListeners();
  }



  Future<void> getProduct() async {
    _productList = await FirebaseFirestoreHelper.instance.getProducts();
    notifyListeners();
  }
  void addProductsList(File image,String name) async {
    CategoryModel c = await
    FirebaseFirestoreHelper.instance.addSingleCategory(image, name);
    _categoriesList.add(c);
    notifyListeners();
  }


  Future<void> deleteProduct(ProductModel productModel) async {
    String message =
    await FirebaseFirestoreHelper.instance.deleteProduct(productModel.categoryId,productModel.id);
    if (message == "Deleted Successfully") {
      _productList.remove(productModel);
      showMessage(message);
    } else {
      notifyListeners();
      showMessage(message);
    }
  }


  List<CategoryModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProductsList => _productList;

  List<UserModel> get userList => _userList;

  bool get getIsDeletingLoading => isDeleteLoading;
  bool get getIsDeletingCategoryLoading => isDeleteCategoryLoading;

  Future<void> callBackFun() async {
    await getUserListFun();
    await getCategoriesFun();
    await getProduct();
  }
}
