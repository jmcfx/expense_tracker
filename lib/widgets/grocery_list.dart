import 'dart:convert';

import 'package:expense_tracker/models/grocery_item_model.dart';
import 'package:expense_tracker/widgets/new_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItemModel> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    const url = "expensetracker-2863d-default-rtdb.firebaseio.com";
    final uri = Uri.https(url, "shopping-list.json");
    final response = await http.get(uri);
    final Map mapData = jsonDecode(response.body);
    for(final item in mapData.entries){

    }
  }

  //addItem... push to newItems Screen....
  void _addItem() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewItems(),
    ));

    _loadItems();
  }

  void _removeItem(GroceryItemModel item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Default Display if it's empty
    Widget content = Center(
      child: Text(
        "No items added yet....",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 20,
            ),
      ),
    );
    // if groceryItems not Empty...
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) => _removeItem(_groceryItems[index]),
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
      
      
    );
  }
}
