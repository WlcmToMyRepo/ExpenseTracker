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
    });
  }

  void _removeExpense(ExpenseData exp) {
    final expenseIndex = expenseData.indexOf(exp);
    deleteData(widget.database!, 'expense', exp.id);

    setState(() {
      expenseData.remove(exp);
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
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
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
      //fetch data from databse with future builder
      body: FutureBuilder(
          future: getData(widget.database!, 'expense'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              expenseData = snapshot.data!
                  .map((e) => ExpenseData.fromMap(map: e))
                  .toList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BarChart(data: expenseData),
                  const Divider(),
                  Expanded(
                    child: expenseData.isEmpty
                        ? Text("No expenses found",
                            style: Theme.of(context).textTheme.titleLarge)
                        : ExpenseList(
                            expenseData: expenseData,
                            removeExpense: _removeExpense,
                          ),
                  ),
                ],
              );
            }
          }),

      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [/*const Text("The Chart"), */ content]
    );
  }
}
