import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//intl date formatter 
final formatter = DateFormat.yMd();
// Uuid package...
const uuid = Uuid();

// category enum....
enum Category { food, travel, leisure, work }

//categoryIcons Map....
const Map categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie
};

//expense Model.....
class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

//date formatter .....
  String get formattedDate => formatter.format(date);
  
}
