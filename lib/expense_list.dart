import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseData> expenseData;

  const ExpenseList({super.key, required this.expenseData});

  Widget getHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: ListView.builder(
          itemCount: expenseData.length,
          itemBuilder: (context, index) => Container(
            child: expenseItem(expenseData[index]),
          ),
        ));
  }

  Widget expenseItem(ExpenseData data) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Rs ${data.amount.toStringAsFixed(2)} ",
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(catergoryIcons[data.category]),
                        const SizedBox(width: 8),
                        Text(data.formatedDate),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
