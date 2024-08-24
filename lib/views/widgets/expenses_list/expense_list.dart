import 'package:expense_tracker/models/models.dart';
import 'package:expense_tracker/views/widgets/expense_item_card.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(color: Theme.of(context).colorScheme.error,
        margin:  const EdgeInsets.symmetric( horizontal: 16),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItemCard(
          expense: expenses[index],
        ),
      ),
    );
  }
}
