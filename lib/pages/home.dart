import 'dart:ui';

import 'package:Expense/database/expense.dart';
import 'package:Expense/widgets/addExpense.dart';
import 'package:Expense/widgets/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  void addExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddExpenseWidget();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      )),
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer: Drawer(),
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addExpense(context),
          backgroundColor: Theme.of(context).primaryColor,
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        'EXPENSES',
        style: GoogleFonts.codaCaption(
            fontSize: 48,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Expense>('expenses').listenable(),
        builder: (context, Box<Expense> box, _) {
          if (box.values.isNotEmpty) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: box.values.length,
                itemBuilder: (_, index) {
                  return ExpenseWidget(expense: box.getAt(index));
                });
          }

          return Container();
        });
  }

  // }
}
