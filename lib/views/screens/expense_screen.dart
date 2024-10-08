import 'package:expense_tracker/models/models.dart';
import 'package:expense_tracker/views/widgets/chart/chart.dart';
import 'package:expense_tracker/views/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/views/widgets/expenses_list/new_expense_modal.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  //registered Expense list
  final List<ExpenseModel> _registeredExpensesList = [
    ExpenseModel(
      title: "Home Made",
      amount: 19.99,
      date: DateTime.now(),
      category: CategoryEvent.work,
    ),
    ExpenseModel(
      title: "Cinema",
      amount: 12.99,
      date: DateTime.now(),
      category: CategoryEvent.leisure,
    )
  ];

  //add new Expense......
  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpensesList.add(expense);
    });
  }

//remove Expense......
  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpensesList.indexOf(expense);
    setState(() {
      _registeredExpensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  ///openAdd ExpenseOverlay.....
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => NewExpenseModal(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some !"),
    );
    if (_registeredExpensesList.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: _registeredExpensesList, onRemoveExpense: _removeExpense);
    }

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
      body: width <= 600
          ?    Column(
              children: [
                //ToolBar with the Add button => Row()
                Chart(
                  expenses: _registeredExpensesList,
                ),
               const  SizedBox(height: 10),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                //ToolBar with the Add button => Row()
                Expanded(
                  child: Chart(
                    expenses: _registeredExpensesList,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
 