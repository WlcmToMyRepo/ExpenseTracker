import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/database/db_service.dart';
import 'package:sqflite/sqflite.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.black12);
ColorScheme kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //create databse
  final Database db = await createDB('expense.db');
  createTable(db, 'expense');
  List<Map<String, dynamic>> raw_data = await getData(db, 'expense');
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      listTileTheme: const ListTileThemeData().copyWith(
          textColor: kDarkColorScheme.primary,
          tileColor: kDarkColorScheme.onSecondary,
          iconColor: kDarkColorScheme.primary,
          subtitleTextStyle:
              TextStyle(color: kDarkColorScheme.primary.withOpacity(.6))),
      textTheme: ThemeData().textTheme.copyWith(
            titleSmall: TextStyle(
              color: kDarkColorScheme.primary,
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
    home: Expenses(
      database: db,
      rawData: raw_data,
    ),
  ));
}
