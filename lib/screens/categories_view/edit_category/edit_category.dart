import 'dart:io';

import 'package:admin_panel/constants/constant.dart';
import 'package:admin_panel/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel category;
  final int index;

  const EditCategory({super.key, required this.category, required this.index});

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  File? image;

  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit Category'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
              ? CupertinoButton(
                  child: const CircleAvatar(
                    radius: 55,
                    child: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                  onPressed: () {
                    takePicture();
                  })
              : CupertinoButton(
                  onPressed: () {},
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          const SizedBox(height: 12),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.category.name,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () async {
                if (image == null && name.text.isEmpty) {
                  Navigator.of(context).pop();
                } else if (image != null) {
                  String imageUrl = await FirebaseStorageHelper.instance
                      .uploadUserImage(image!);
                  CategoryModel categoryModel = widget.category.copyWith(
                      name:
                          name.text.isEmpty ? widget.category.name : name.text,
                      image: imageUrl);
                  appProvider.updateCategoryList(widget.index, categoryModel);
                  showMessage('Category Updated Successfully');
                }else{
                  CategoryModel categoryModel = widget.category.copyWith(
                      name:
                      name.text.isEmpty ? widget.category.name : name.text,);
                  appProvider.updateCategoryList(widget.index, categoryModel);
                  showMessage('Category Updated Successfully');
                }
              },
              child: const Text('Update Category'))
        ],
      ),
    );
  }
}
