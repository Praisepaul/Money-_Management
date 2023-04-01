import 'package:js/js.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagementapp/models/category/category_model.dart';
import 'package:moneymanagementapp/models/transactions/transaction_model.dart';
import 'package:moneymanagementapp/screens/home/screen_home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementapp/screens/transactions/add_transactions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  
  if (!Hive.isAdapterRegistered(TransactionModalAdapter().typeId)) {
    Hive.registerAdapter(TransactionModalAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenHome(),
      routes: {
        addTransaction.routeName:(ctx) =>const addTransaction(),
      },
    );
  }
}
