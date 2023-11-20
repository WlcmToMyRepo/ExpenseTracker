import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';

class NewExpense extends StatefulWidget {
  final void Function(ExpenseData) addToExpense;

  const NewExpense({super.key, required this.addToExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime? selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();
    final startDate = DateTime(now.year - 1, now.month, now.day);
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: startDate,
        lastDate: now);
    setState(() {});
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(amount.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (title.text.trim().isEmpty || invalidAmount || selectedDate == null) {
      //show error message
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Invalid input"),
                content: const Text("Please enter proper details"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              ));
    } else {
      widget.addToExpense(ExpenseData(
          title: title.text.trim(),
          amount: enteredAmount,
          date: selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context);
    }
    return;
  }

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardHeight + 16),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.titleMedium,
              controller: title,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("title")),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleMedium,
                    controller: amount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text("amount"), prefixText: "\u20B9  "),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? "select date"
                          : formatter.format(selectedDate!),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                      style: Theme.of(context).textTheme.titleMedium,
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: _submitExpenseData, child: const Text("Save")),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
