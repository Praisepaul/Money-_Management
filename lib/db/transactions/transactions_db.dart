import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementapp/models/transactions/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransactions(TransactionModal obj);
  Future<List<TransactionModal>> getAllTransactions();
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModal>> transactionList = ValueNotifier([]);

  @override
  Future<void> addTransactions(TransactionModal obj) async {
    final _db = await Hive.openBox<TransactionModal>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    transactionList.value.clear();
    transactionList.value.addAll(_list);
    transactionList.notifyListeners();
  }

  @override
  Future<List<TransactionModal>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModal>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }
}
