import 'package:expense_tracker/chart_bar.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
//import 'package:expense_tracker/chart_bar.dart;

class Chart extends StatelessWidget {
  Chart({super.key, required this.expenses});

  final List<ExpenseModel> expenses;
  final List<Category> catList=[Category.food, Category.travel , Category.work , Category.shopping];

  List<double> get bucket {
    return [
      Expenses(expList:expenses).categoryTotal(Category.food),
      Expenses(expList:expenses).categoryTotal(Category.travel),
      Expenses(expList:expenses).categoryTotal(Category.work),
      Expenses(expList:expenses).categoryTotal(Category.shopping),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final exp in bucket) {
      if (exp > maxTotalExpense) {
        maxTotalExpense = exp;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: width<600?180:200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final exp in bucket) // alternative to map()
                  ChartBar(
                    fill: exp == 0
                        ? 0
                        : exp / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: catList
                .map(
                  (ctgry) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcon[ctgry],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}