import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final double data;
  const Bar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // print(
    //     "MAX AMOUNT $maxAmount \n TOTAL AMOUNT $totalAmount and value ${totalAmount / maxAmount}");
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: data,
            widthFactor: .5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(5),
                    bottom: Radius.zero,
                  )),
            ),
          ),
        ));
  }
}
