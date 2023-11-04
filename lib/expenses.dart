import 'package:expense_tracker/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseData> someExpenses = [
    ExpenseData(
        title: "Food",
        amount: 1000,
        date: DateTime.now(),
        category: Category.food),
    ExpenseData(
        title: "Movie",
        amount: 200,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SpentY"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("The Chart"),
            ExpenseList(expenseData: someExpenses),
          ],
        ),
      ),
    );
  }
}
