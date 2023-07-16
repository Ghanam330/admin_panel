import 'dart:io';
import 'package:admin_panel/constants/constant.dart';
import 'package:admin_panel/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Product'),
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
              hintText: "Product Name",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: description,
            decoration: const InputDecoration(
              hintText: "Product Description",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: price,
            decoration: const InputDecoration(
              hintText: "Product Price",
            ),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              hintText: "Product Category",
            ),
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            items: appProvider.getCategoriesList.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () async {
                if (image == null ||
                    name.text.isEmpty ||
                    description.text.isEmpty ||
                    price.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill all the fields')));
                } else {
                  appProvider.addProductList(
                    image!,
                    name.text,
                    _selectedCategory!.id,
                    price.text,
                    description.text,
                  );
                }
              },
              child: const Text('Add Product'))
        ],
      ),
    );
  }
}
