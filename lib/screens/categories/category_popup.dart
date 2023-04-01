import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagementapp/db/category/category_db.dart';
import 'package:moneymanagementapp/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add new category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Category Name',
                    prefixIcon: Icon(Icons.category_rounded)),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: const [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expenses', type: CategoryType.expense),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = selectedCategory.value;
                  final _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _name,
                      type: _type);
                  CategoryDB.instance.insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Add'),
              ),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategory,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: ((value) {
                  if (value != null) {
                    selectedCategory.value = value;
                    selectedCategory.notifyListeners();
                  }
                }),
              );
            }),
        Text(title),
      ],
    );
  }
}
