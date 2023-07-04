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

  void updateCategory(int index,CategoryModel categoryModel) async {
    FirebaseFirestoreHelper.instance.updateCategory(categoryModel);
    _categoriesList[index] = categoryModel;
    notifyListeners();
  }

  List<CategoryModel> get categoriesList => _categoriesList;

  List<UserModel> get userList => _userList;

  bool get getIsDeletingLoading => isDeleteLoading;

  Future<void> callBackFun() async {
    await getUserListFun();
    await getCategoriesFun();
  }
}
