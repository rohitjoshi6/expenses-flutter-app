import 'dart:ui';

import 'package:Expense/database/moor_database.dart';
import 'package:Expense/widgets/addExpense.dart';
import 'package:Expense/widgets/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
      // actions: [
      //   IconButton(
      //       icon: Icon(Icons.mode_edit), onPressed: () => addExpense(context))
      // ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final _expenseListProvider = Provider.of<AppDatabase>(context);
    return _buildListView(context);
  }

  StreamBuilder<List<Expense>> _buildListView(context) {
    final _expenseListProvider = Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: _expenseListProvider.watchAllExpense(),
      builder: (context, AsyncSnapshot<List<Expense>> snapshot) {
        final expenses = snapshot.data ?? [];

        return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: expenses.length,
            itemBuilder: (_, index) {
              return ExpenseWidget(
                expense: expenses[index],
                expenseListProvider: _expenseListProvider,
              );
            });
      },
    );
  }
}
