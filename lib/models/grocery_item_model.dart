import 'package:expense_tracker/models/category_model.dart';


class GroceryItemModel {
  final String id, name;
  final int quantity;
  final CategoryModel category;

  GroceryItemModel({required this.id, required this.name, required this.quantity, required this.category});
}
