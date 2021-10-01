import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Expense/database/moor_database.dart';

class ExpenseWidget extends StatelessWidget {
  final Expense expense;
  final expenseListProvider;

  ExpenseWidget({this.expense, this.expenseListProvider});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAmountDisplay(context),
            _buildItemDisplay(context),
            _buildDateDisplay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountDisplay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${expense.amount}",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "RS",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.black54,
          ),
          onPressed: () {
            expenseListProvider.deleteExpense(expense);
          },
        ),
      ],
    );
  }

  Widget _buildItemDisplay(BuildContext context) {
    return Container(
      child: Text(
        "${expense.description}",
        textAlign: TextAlign.justify,
        style: GoogleFonts.ubuntu(
          color: Colors.black54,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateDisplay(BuildContext context) {
    var newDt = DateFormat.yMMMEd().format(expense.time);
    var newDtHour = DateFormat.jm().format(expense.time);
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          "$newDtHour $newDt",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
