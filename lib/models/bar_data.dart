import 'package:expense_tracker/models/expense_data.dart';

class BarData {
  final double total;
  final Category category;

  BarData(this.total, this.category);

  factory BarData.fromExpense(
      {required List<ExpenseData> data, required Category category}) {
    double totalAmount = 0;
    final categorisedData = data
        .where((e) => e.category.name.toString() == category.name.toString())
        .toList();
    final amounts = categorisedData.map((e) => e.amount);
    totalAmount = amounts.reduce((value, element) => value + element);
    return BarData(totalAmount, category);
  }
}
