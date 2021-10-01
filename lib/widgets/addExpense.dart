import 'package:Expense/database/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseWidget extends StatefulWidget {
  @override
  _AddExpenseWidgetState createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  double amount = 0;

  String item = "Empty";

  @override
  Widget build(BuildContext context) {
    final _expenseListProvider = Provider.of<AppDatabase>(context);
    var primaryColor = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => amount = double.parse(value),
              onFieldSubmitted: (value) => amount = double.parse(value),
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Amount",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) => item = value,
              onFieldSubmitted: (value) => item = value,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Item Description",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (amount == 0 || item == 'Empty') {
                  _alertEmptyInput(amount == 0, item == 'Empty');
                } else {
                  // amount,item
                  _expenseListProvider.insertExpense(new Expense(
                      amount: amount, time: DateTime.now(), description: item));
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                splashFactory: InkSplash.splashFactory,
                backgroundColor: MaterialStateProperty.all(primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Container(
                height: 60,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Text(
                    "Add Expense",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _alertEmptyInput(hasAmount, hasMessage) async {
    String empty = '';
    if (hasAmount) {
      empty = 'amount';
    } else {
      empty = 'message';
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bad Input'),
          content: Text('You cannot leave ' + empty + ' empty!'),
          actions: <Widget>[
            TextButton(
              child: Text('Understood'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
