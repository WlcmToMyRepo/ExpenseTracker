import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartApp extends StatelessWidget {
  final List<ExpenseData> data;
  const ChartApp({super.key, required this.data});

  double get totalExpense =>
      data.map((e) => e.amount).reduce((value, element) => value + element);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.blue,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          height: 500,
          width: double.infinity,
          child: BarChart(
            BarChartData(
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                maxY: totalExpense,
                barGroups: [
                  BarChartGroupData(
                    x: totalExpense.toInt(),
                    barsSpace: 5,
                    barRods: data
                        .map((items) => BarChartRodData(
                              toY: items.amount,
                            ))
                        .toList(),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
