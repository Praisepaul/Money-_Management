import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagementapp/db/category/category_db.dart';
import 'package:moneymanagementapp/screens/categories/expense_list.dart';
import 'package:moneymanagementapp/screens/categories/income_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expenses',
            )
          ],
          labelColor: Color.fromARGB(255, 250, 0, 9),
          unselectedLabelColor: Color.fromARGB(255, 3, 147, 89),
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            IncomeCategory(),
            ExpenseCategory(),
          ]),
        )
      ],
    );
  }
}
