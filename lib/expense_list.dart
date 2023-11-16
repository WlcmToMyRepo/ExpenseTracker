import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseData> expenseData;
  final void Function(ExpenseData) removeExpense;

  const ExpenseList(
      {super.key, required this.expenseData, required this.removeExpense});

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
    print("EXPANSE DATA $expenseData");
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: expenseData.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(color: Theme.of(context).colorScheme.error),
        key: ValueKey(expenseData[index]),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          removeExpense(expenseData[index]);
        },
        child: expenseItem2(expenseData[index], context),
      ),
    ));
  }

  Widget expenseItem2(ExpenseData data, BuildContext context) {
    return ListTile(
      leading: Icon(catergoryIcons[data.category]),
      leadingAndTrailingTextStyle: Theme.of(context).textTheme.titleMedium,
      title: Text(data.title),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      trailing: Text("\u20B9 ${data.amount.toStringAsFixed(2)}"),
      subtitle: Text(
        data.formatedDate,
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
    );
  }

  Widget expenseItem(ExpenseData data, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Rs ${data.amount.toStringAsFixed(2)} ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(catergoryIcons[data.category]),
                    const SizedBox(width: 8),
                    Text(
                      data.formatedDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
