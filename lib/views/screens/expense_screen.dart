import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/views/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/views/widgets/expenses_list/new_expense_modal.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<ExpenseModel> _registeredExpensesList = [
    ExpenseModel(
      title: "Home Made",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: "Cinema",
      amount: 12.99,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => const NewExpenseModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          //ToolBar with the Add button => Row()
          const Text("The Chart"),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ExpenseList(expenses: _registeredExpensesList),
          )
        ],
      ),
    );
  }
}
