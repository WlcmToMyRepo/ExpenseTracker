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
      isScrollControlled: true,
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

  void _removeExpense(ExpenseData exp) {
    final expenseIndex = expenseData.indexOf(exp);
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
      body: Container(
        height: 800,
        child: content,
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.max,
        //   children: [/*const Text("The Chart"), */ content]
      ),
    );
  }
}
