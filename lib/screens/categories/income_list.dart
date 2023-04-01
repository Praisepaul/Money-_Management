import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagementapp/db/category/category_db.dart';
import 'package:moneymanagementapp/models/category/category_model.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder:
            (BuildContext context, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final category = newList[index];
                return Card(
                  color: Colors.blueAccent,
                  child: ListTile(
                    textColor: Colors.white,
                    title: Text(category.name),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDB.instance.deleteCategory(category.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: newList.length);
        });
  }
}
