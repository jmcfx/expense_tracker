import 'package:expense_tracker/data/categories.dart';
import 'package:expense_tracker/models/category_model.dart';

import 'package:expense_tracker/models/grocery_item_model.dart';

 final  groceryItems = [
  GroceryItemModel(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categoriesList[Categories.dairy]!
      ),
  GroceryItemModel(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categoriesList[Categories.fruit]!
      ),
  GroceryItemModel(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categoriesList[Categories.meat]!
      ),
];
