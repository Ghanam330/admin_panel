import 'dart:io';

import 'package:admin_panel/constants/constant.dart';
import 'package:admin_panel/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
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
            decoration: const InputDecoration(
              hintText: "Category Name",
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () async {
                if (image == null && name.text.isEmpty) {
                  Navigator.of(context).pop();
                } else if (image != null && name.text.isNotEmpty) {
                  appProvider.addCategoryList(image!, name.text);
                  showMessage("Category Added Successfully");
                }
              },
              child: const Text('Add Category'))
        ],
      ),
    );
  }
}
