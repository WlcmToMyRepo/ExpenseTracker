import 'package:expense_tracker/chart/bar_chart.dart';
import 'package:expense_tracker/database/db_service.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:sqflite/sqflite.dart';

class Expenses extends StatefulWidget {
  final Database? database;
  final List<Map<String, dynamic>> rawData;
  const Expenses({super.key, required this.database, required this.rawData});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<ExpenseData> expenseData = [];

  void get clearExpense {
    expenseData = [];
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        addToExpense: _addExpense,
      ),
    );
  }

  void _addExpense(ExpenseData data) {
    //insert to database

    insertData(widget.database!, 'expense', data.toMap());
    setState(() {
      expenseData.add(data);
      clearExpense;
    });
  }

  void _removeExpense(ExpenseData exp) {
    final expenseIndex = expenseData.indexOf(exp);
    deleteData(widget.database!, 'expense', exp.id);

    setState(() {
      expenseData.remove(exp);
      clearExpense;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted.."),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: "undo",
        onPressed: () {
          insertData(widget.database!, 'expense', exp.toMap());
          setState(() {
            expenseData.insert(expenseIndex, exp);
            clearExpense;
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    clearExpense;
    for (var map in widget.rawData) {
      expenseData.add(ExpenseData.fromMap(map: map));
    }
    Widget content = Center(
      child: Text("No expenses found",
          style: Theme.of(context).textTheme.titleLarge),
    );
    if (expenseData.isNotEmpty) {
      content = ExpenseList(
        expenseData: expenseData,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xpense"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BarChart(data: expenseData),
          const Divider(),
          Expanded(child: content),
        ],
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [/*const Text("The Chart"), */ content]
    );
  }
}
