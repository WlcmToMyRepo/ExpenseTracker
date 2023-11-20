import 'dart:math';

import 'package:expense_tracker/chart/bar.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<ExpenseData> data;
  const BarChart({super.key, required this.data});

  double getBarValue(max, amount) {
    double value = amount / max;
    if (value.isNaN) return 0;
    return value;
  }

  double get maxAmount {
    return ExpenseBucket(expenses: data).totalExpense;
  }

  List<ExpenseBucket> get buckets {
    return Category.values
        .map((cat) => ExpenseBucket.getExpenseFromCategory(cat, data))
        .toList();
  }

  Widget getText(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Widget getIcon(BuildContext context, iconData) {
    return Icon(
      iconData,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxexp = maxAmount;
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      height: 180,
      // decoration:
      //     BoxDecoration(border: Border.all(width: 2, color: Colors.red)),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets
                  .map((e) => Bar(data: getBarValue(maxexp, e.totalExpense)))
                  .toList(),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getIcon(context, catergoryIcons[Category.food]),
                getIcon(context, catergoryIcons[Category.travel]),
                getIcon(context, catergoryIcons[Category.leisure]),
                getIcon(context, catergoryIcons[Category.work]),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buckets
                  .map((bucket) =>
                      getText(context, bucket.totalExpense.toString()))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
