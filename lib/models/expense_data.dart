import 'package:uuid/uuid.dart';

const uuid = Uuid(); // object of uniq id

enum Category {
  food,
  travel,
  leisure,
  work
} // enums are special type of custom data holder we are using here for defining custom category

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
}
