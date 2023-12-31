import 'package:expense_tracker/models/expense_data.dart';

class ChartData {
  final List<ExpenseData> data;
  final Category category;

  ChartData({required this.data, required this.category});

  ChartData.filterCategory(List<ExpenseData> expenses, this.category)
      : data =
            expenses.where((element) => element.category == category).toList();
}
