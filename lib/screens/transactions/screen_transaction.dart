import 'package:flutter/material.dart';
import 'package:moneymanagementapp/db/transactions/transactions_db.dart';
import 'package:moneymanagementapp/models/transactions/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionList,
        builder:
            (BuildContext ctx, List<TransactionModal> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Card(
                color: Colors.indigo.shade200,
                shadowColor: Colors.green.shade300,
                child:  ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 234, 13, 212),
                      foregroundColor: Colors.white,
                      radius: 68,
                      child: Text(
                        '12-12-23',
                        textAlign: TextAlign.center,
                      )),
                  title: Text('Rs. ${_value.amount}'),
                  subtitle: Text(_value.category.name),
                ),
              );
            },
            separatorBuilder: ((ctx, index) => const SizedBox(
                  height: 10,
                )),
            itemCount: newList.length,
          );
        });
  }
}
