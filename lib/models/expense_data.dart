import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid(); // object of uniq id

final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work
} // enums are special type of custom data holder we are using here for defining custom category

Map<Category, dynamic> catergoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseData {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseData(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); //uuid.v4 method generates an uniq id

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category? category;
  final List<ExpenseData> expenses;

  ExpenseBucket({this.category, required this.expenses});

  ExpenseBucket.getExpenseFromCategory(this.category, List<ExpenseData> data)
      : expenses =
            data.where((expense) => expense.category == category).toList();

  double get totalExpense {
    double sum = 0;
    for (final exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }
}
