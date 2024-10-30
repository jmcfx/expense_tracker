import 'dart:convert';

import 'package:expense_tracker/data/categories.dart';
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
  List<GroceryItemModel> _groceryItems = [];
  var _isLoading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    const url = "expensetracker-2863d-default-rtdb.firebaseio.com";
    final uri = Uri.https(url, "shopping-list.json");
    try{
         final response = await http.get(uri);
    }catch (e){}
    
    final response = await http.get(uri);
    if (response.statusCode >= 400) {
      setState(() {
        _error = "Failed to fetch data. Please try again later ";
      });
    }

    if (response.body == "null") {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final Map listData = jsonDecode(response.body);
    final List<GroceryItemModel> loadedItems = [];

    for (final item in listData.entries) {
      final category = categoriesMap.entries
          .firstWhere((e) => e.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItemModel(
          id: item.key,
          name: item.value["name"],
          quantity: item.value["quantity"],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

  //addItem... push to newItems Screen....
  void _addItem() async {
    final newItem = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewItems(),
    ));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItemModel item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    const url = "expensetracker-2863d-default-rtdb.firebaseio.com";
    final uri = Uri.https(url, "shopping-list/${item.id}.json");
    final response = await http.delete(uri);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
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

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
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
    if (_error != null) {
      content = Center(child: Text(_error!));
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
