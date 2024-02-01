import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {required this.removeExpense, required this.listOfExp, super.key});
  final List<ExpenseModel> listOfExp;
  final void Function(ExpenseModel) removeExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfExp.length,
      itemBuilder: (ctx, idx) => Dismissible(
        background: Opacity(
          opacity: 0.8,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 216, 32, 19),
              borderRadius: BorderRadius.circular(25),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: const Text(
              "Delete",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
        ),
        key: ValueKey(listOfExp[idx]),
        onDismissed: (direction) {
          removeExpense(listOfExp[idx]);
        },
        child: ExpenseItem(
          listOfExp[idx],
        ),
      ),
    );
  }
}
