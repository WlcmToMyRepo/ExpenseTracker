import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/new_expense.dart';
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
  final List<ExpenseData> expenseData = [
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpense(
        addToExpense: _addExpense,
      ),
    );
  }

  void _addExpense(ExpenseData data) {
    setState(() {
      expenseData.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xpense"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text("The Chart"),
            ExpenseList(expenseData: expenseData),
          ],
        ),
      ),
    );
  }
}
