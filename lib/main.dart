import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/chart/bar_chart.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.black);
ColorScheme kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.dark);

/*void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      listTileTheme: const ListTileThemeData().copyWith(
          textColor: kDarkColorScheme.onSecondary,
          tileColor: kDarkColorScheme.onSecondaryContainer,
          iconColor: kDarkColorScheme.onSecondary,
          subtitleTextStyle:
              TextStyle(color: kDarkColorScheme.onSecondary.withOpacity(.6))),
      textTheme: ThemeData().textTheme.copyWith(
            titleSmall: TextStyle(
              color: kDarkColorScheme.onSecondary,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            titleMedium: TextStyle(
              color: kDarkColorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.onSecondaryContainer,
          foregroundColor: kDarkColorScheme.onSecondary,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      //styling card theme
      cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 10,
          )),
      //styling appbar
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.onSecondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.onSecondaryContainer,
        foregroundColor: kColorScheme.onSecondary,
      )),
      textTheme: ThemeData().textTheme.copyWith(
          titleSmall: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          titleMedium: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer)),
      listTileTheme: const ListTileThemeData().copyWith(
          textColor: kColorScheme.onSecondary,
          tileColor: kColorScheme.onSecondaryContainer,
          iconColor: kColorScheme.onSecondary,
          subtitleTextStyle:
              TextStyle(color: kColorScheme.onSecondary.withOpacity(.5))),
    ),
    debugShowCheckedModeBanner: false,
    title: "ExpenseTracker",
    home: const Expenses(),
  ));
}*/

void main() {
  runApp(MaterialApp(
    home: ChartApp(data: [
      ExpenseData(
          title: "Food",
          amount: 2000,
          date: DateTime.now(),
          category: Category.food),
      ExpenseData(
          title: "Kundapur",
          amount: 2000,
          date: DateTime.now(),
          category: Category.travel),
      ExpenseData(
          title: "Movie",
          amount: 2000,
          date: DateTime.now(),
          category: Category.leisure),
      ExpenseData(
          title: "Omlete",
          amount: 20,
          date: DateTime.now(),
          category: Category.food),
      ExpenseData(
          title: "fruit",
          amount: 200,
          date: DateTime.now(),
          category: Category.food),
    ]),
  ));
}
