import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() {
    return _ExpensesAppState();
  }
}

class _ExpensesAppState extends State<ExpensesApp> {
  final List<ExpenseModel> _expenseList = [];
  void updateList(ExpenseModel newexp) {
    setState(() {
      _expenseList.add(newexp);
    });
  }

  void _addExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: updateList),
    );
  }

  void _onRemove(ExpenseModel exp) {
    int expIdx = _expenseList.indexOf(exp);
    setState(() {
      _expenseList.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text("Item deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _expenseList.insert(expIdx, exp);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense added , try adding some! "),
    );

    double totalExpense = Expenses(expList: _expenseList).totalExpense;

    if (_expenseList.isNotEmpty) {
      mainContent = ExpenseList(
        listOfExp: _expenseList,
        removeExpense: _onRemove,
      );
    }

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _addExpense,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
        title: const Text(
          "Expense Tracker",
        ),
      ),
      body: Center(
        child: width < 600
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: Text("Total expense : $totalExpense "),
                  ),
                  Chart(expenses: _expenseList),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Chart(expenses: _expenseList),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal:16, vertical: 8),
                        alignment: Alignment.centerLeft,
                        child: Text("Total expense : $totalExpense "),
                      ),
                    ],
                  )),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ),
      ),
    );
  }
}
