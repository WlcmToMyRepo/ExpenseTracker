import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseData> expenseData;

  const ExpenseList({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: ListView.builder(
          itemCount: expenseData.length,
          itemBuilder: (context, index) => Container(
            child: expenseItem(expenseData[index]),
          ),
        ));
  }

  Widget expenseItem(ExpenseData data) {
    return SizedBox(
      child: Card(
          color: Colors.yellow,
          shadowColor: Colors.black,
          elevation: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Text(data.id),
                Text(data.title),
                Text("Rs ${data.amount.toStringAsFixed(2)}"),
                Text("${data.date}"),
                Text("${data.category}")
              ],
            ),
          )),
    );
  }
}
