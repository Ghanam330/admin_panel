import 'package:admin_panel/constants/colors.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/categories_view/add_categories/add_categories.dart';
import 'package:admin_panel/screens/categories_view/edit_category/edit_category.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: const Text('Categories View'),
          actions: [
            IconButton(
              onPressed: () {
                Routes.instance.push(
                    widget: AddCategory(),
                    context: context);
              },
              icon: const Icon(Icons.add),
            ),
          ]
        ),
        body: Consumer<AppProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories', style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: value.getCategoriesList.length,
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel = value.getCategoriesList[index];
                      return Card(
                        color: Colors.white,
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                child: Image.network(
                                  categoryModel.image,
                                  scale: 1.9,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    value.getIsDeletingLoading
                                        ? CircularProgressIndicator()
                                        : GestureDetector(
                                            onTap: () {
                                              value.deleteCategory(
                                                  categoryModel);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        Routes.instance.push(
                                            widget: EditCategory(
                                                category: categoryModel,
                                                index: index),
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
                    },
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
