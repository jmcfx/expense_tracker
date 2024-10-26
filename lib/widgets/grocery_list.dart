import 'package:expense_tracker/models/grocery_item_model.dart';
import 'package:expense_tracker/widgets/new_items.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItemModel> _groceryItems = [];
  //addItem... push to newItems Screen....
  void _addItem() async {
    final newItems = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewItems(),
    ));

    if (newItems == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItems);
    });
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
        body: content);
  }
}
