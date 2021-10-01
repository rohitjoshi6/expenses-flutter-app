import 'package:Expense/database/expense.dart';
import 'package:Expense/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expenses');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter",
      theme: theme(),
      home: HomePage(),
    );
  }

  ThemeData theme() {
    return ThemeData(
      primaryColor: Colors.deepPurple,
    );
  }
}
