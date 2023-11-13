import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/models/chart_data.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartApp extends StatelessWidget {
  final List<ExpenseData> data;
  const ChartApp({super.key, required this.data});

  double get totalExpense =>
      data.map((e) => e.amount).reduce((value, element) => value + element);

  List<ChartData> get barData {
    return Category.values
        .map((e) => ChartData.filterCategory(data, e))
        .toList();
  }

  List<BarChartGroupData> get barGroups {
    final items = barData;
    List<BarChartGroupData> list = [];
    for (var i = 0; i < items.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            toY: items[i].getAmount,
            width: 50,
            color: const Color.fromARGB(133, 31, 12, 27),
            /*gradient: const LinearGradient(
              colors: [
                Color.fromARGB(0, 34, 2, 12),
                Color.fromARGB(0, 32, 3, 12),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),*/
            borderRadius: const BorderRadius.vertical(
                bottom: Radius.zero, top: Radius.circular(5))),
      ]));
    }
    return list;
  }

  Widget getTitles(double value, TitleMeta meta) {
    var icon;
    switch (value.toInt()) {
      case 0:
        icon = catergoryIcons[Category.food];
        break;
      case 1:
        icon = catergoryIcons[Category.travel];
        break;
      case 2:
        icon = catergoryIcons[Category.leisure];
      case 3:
        icon = catergoryIcons[Category.work];
        break;
      default:
        icon = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // dynamic x = barData;
    // print("THIS WILL DISPLAY $x");
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            // borderRadius: const BorderRadius.all(Radius.circular(50)),
            /*gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white70,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),*/
          ),
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              titlesData: titlesData,
              gridData: const FlGridData(
                show: false,
                drawHorizontalLine: false,
              ),
              maxY: totalExpense,
              alignment: BarChartAlignment.spaceBetween,
              barGroups: barGroups,

              /*barData
                    .map(
                      (bar) => BarChartGroupData(x: , barsSpace: 5, barRods: [
                        BarChartRodData(
                          width: 50,
                          toY: bar.getAmount,
                          color: Colors.black,
                        ),
                      ]),
                    )
                    .toList(),*/
            ),
          ),
        ),
      ),
    );
  }
}
