import "package:expense_tracker/model/expense_model.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: const Color.fromARGB(255, 156, 154, 154),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("Rs.${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Icon(categoryIcon[expense.expType]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(expense.formattedDate)
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
