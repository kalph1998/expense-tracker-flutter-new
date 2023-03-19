import 'package:expense_calculator/components/expense_tile.dart';
import 'package:expense_calculator/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/expense_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
            ),
            TextField(
              controller: newExpenseAmountController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  void save() {
    // create new expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.of(context).pop();
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                    name: value.getExpenseList()[index].name,
                    amount: value.getExpenseList()[index].amount,
                    dateTime: value.getExpenseList()[index].dateTime),
              ),
            ],
          )),
    );
  }
}
