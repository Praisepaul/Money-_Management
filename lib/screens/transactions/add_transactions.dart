// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moneymanagementapp/db/category/category_db.dart';
import 'package:moneymanagementapp/db/transactions/transactions_db.dart';
import 'package:moneymanagementapp/models/category/category_model.dart';
import 'package:moneymanagementapp/models/transactions/transaction_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);
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

class addTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const addTransaction({super.key});

  @override
  State<addTransaction> createState() => _addTransactionState();
}

class _addTransactionState extends State<addTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;
  final _purposeTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              controller: _purposeTextController,
              decoration: const InputDecoration(
                hintText: 'Purpose',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
            TextFormField(
              controller: _amountTextController,
              decoration: const InputDecoration(
                hintText: 'Amount',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
              keyboardType: TextInputType.number,
            ),
            TextButton.icon(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (selectedDate == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today_rounded),
                label: Text(_selectedDate == null
                    ? 'Select a Date'
                    : _selectedDate!.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    RadioButton(
                      type: CategoryType.income,
                      title: '',
                    ),
                    Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    RadioButton(
                      type: CategoryType.expense,
                      title: '',
                    ),
                    Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
              hint: const Text('Select a Category'),
              value: _categoryID,
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDB().incomeCategoryListListener
                      : CategoryDB().expenseCategoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedCategoryModel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _categoryID = selectedValue;
                });
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                addTransaction();
              },
              icon: Icon(Icons.check),
              label: Text('Submit'),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purpose = _purposeTextController.text;
    final _amount = _amountTextController.text;

    if (_purpose.isEmpty) {
      return;
    }
    if (_amount.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amount);
    if (_parsedAmount == null) {
      return;
    }
    //_selectedDate
    //_selectedCategoryType
    final _model = TransactionModal(
        purpose: _purpose,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!);

    await TransactionDB.instance.addTransactions(_model);
    Navigator.of(context).pop();
  }
}
