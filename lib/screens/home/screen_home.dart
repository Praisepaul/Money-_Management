import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagementapp/db/category/category_db.dart';
import 'package:moneymanagementapp/main.dart';
import 'package:moneymanagementapp/models/category/category_model.dart';
import 'package:moneymanagementapp/screens/categories/category_popup.dart';
import 'package:moneymanagementapp/screens/categories/screen_category.dart';
import 'package:moneymanagementapp/screens/home/widgets/bottomNavigation.dart';
import 'package:moneymanagementapp/screens/transactions/add_transactions.dart';
import 'package:moneymanagementapp/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  final pages = const [ScreenCategory(), ScreenTransactions()];

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 233, 252),
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
        leading: const Icon(Icons.currency_rupee),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context, int updatedIndex, _) {
          return pages[updatedIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndex.value == 0) {
            showCategoryAddPopup(context);
            
            // final sample = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: 'Travel', type: CategoryType.expense);
            // CategoryDB().insertCategory(sample);
          } else {
            Navigator.of(context).pushNamed(addTransaction.routeName);
          }
        },
        hoverColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }
}
