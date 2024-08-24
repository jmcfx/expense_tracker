import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//intl date formatter
final formatter = DateFormat.yMd();
// Uuid package...
const uuid = Uuid();

// category enum....
enum CategoryEvent { food, travel, leisure, work }

//categoryIcons Map....
const Map categoryIcons = {
  CategoryEvent.food: Icons.lunch_dining,
  CategoryEvent.travel: Icons.flight_takeoff,
  CategoryEvent.work: Icons.work,
  CategoryEvent.leisure: Icons.movie
};

//expense Model.....
class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryEvent category;

  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

//date formatter .....
  String get formattedDate => formatter.format(date);
}

// Expenses Bucket.......takes an instance if Expense model as on of it's constructor properties...
class ExpensesBucket {
  final CategoryEvent categoryEvent;
  final List<ExpenseModel> expenses;

  ExpensesBucket({required this.categoryEvent, required this.expenses});

//expensesBucket Category....
  ExpensesBucket.forCategory(List<ExpenseModel> allExpenses, this.categoryEvent)
      : expenses = allExpenses
            .where((allExpenses) => allExpenses.category == categoryEvent)
            .toList();

// totalExpenses .....
  double get totalExpenses {
    double sum = 0;

    //loop through all the expenses into expense
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
