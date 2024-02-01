import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense( {required this.onAddExpense, super.key});
  final void Function(ExpenseModel) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense> {
  final titleControl = TextEditingController();
  final amountControl = TextEditingController();
  DateTime? date ;
  Category expCat = Category.food;

  @override
  void dispose() {
    titleControl.dispose();
    amountControl.dispose();
    super.dispose();
  }

  void _datePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    setState(() {
      date = selectedDate!;
    });
  }

  void submitNewExpense() {
    final amount=double.tryParse(amountControl.text);
    final title=titleControl.text;
    final enteredDate=date;
    final notValidAmount= amount== null || amount<=0;
    if( notValidAmount || title.trim().isEmpty || enteredDate==null ){
      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: const Text("INVALID DETAILS"),
        content: const Text("Please enter the correct title , amount and date "),
         actions: [
          TextButton(onPressed: ()=>Navigator.pop(ctx), child: const Text("OKAY"))
         ],
        ),
      );
      return;
    }
    widget.onAddExpense(ExpenseModel(
        title: title,
        amount: amount,
        expDate: enteredDate,
        expType: expCat,
      ),);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18,50,18,18),
      child: Column(
        children: [
          TextField(
            controller: titleControl,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountControl,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  decoration: const InputDecoration(
                    prefixText: 'Rs.',
                    label: Text("Amount"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      date==null?"Select Date":formatter.format(date!),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: _datePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: expCat,
                items: Category.values
                    .map((e) => DropdownMenuItem(
                        value: e, child: Text(e.name.toUpperCase())))
                    .toList(),
                onChanged: (e) {
                  if (e == null) return;
                  setState(() {
                    expCat = e;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: submitNewExpense,
                child: const Text("Submit"),
              )
            ],
          )
        ],
      ),
    );
  }
}
