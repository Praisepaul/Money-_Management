import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagementapp/models/category/category_model.dart';
import 'package:moneymanagementapp/screens/categories/income_list.dart';

const Category_DB_Name = 'category-database';

abstract class categoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements categoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
}
