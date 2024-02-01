import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var clrScheme = ColorScheme.fromSeed(
  seedColor: Colors.purple,
);
var darkClrScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 10, 8, 67),
);
void main() {
  return runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: darkClrScheme,
      cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shadowColor: const Color.fromARGB(255, 46, 45, 40),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkClrScheme.primaryContainer,
        foregroundColor: darkClrScheme.onPrimaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkClrScheme.primaryContainer,
          foregroundColor: darkClrScheme.onPrimaryContainer,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
      colorScheme: clrScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: clrScheme.onPrimaryContainer,
        foregroundColor: clrScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: clrScheme.primaryContainer,
          foregroundColor: clrScheme.onPrimaryContainer,
        ),
      ),
    ),
    home: const ExpensesApp(),
  ));
}
