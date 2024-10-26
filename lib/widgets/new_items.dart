import 'package:expense_tracker/data/categories.dart';
import 'package:expense_tracker/models/category_model.dart';
import 'package:expense_tracker/models/grocery_item_model.dart';
import 'package:flutter/material.dart';

class NewItems extends StatefulWidget {
  const NewItems({super.key});

  @override
  State<NewItems> createState() => _NewItemsState();
}

class _NewItemsState extends State<NewItems> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredQuantity = 1;
  var _selectedCategory = categoriesMap[Categories.vegetables]!;
  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(GroceryItemModel(id: DateTime.now().toString(), name: _enteredName, quantity: _enteredQuantity ,category: _selectedCategory),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        //form ...
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                //name...
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text("Name")),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Must be between 1 and 50 characters Long  ";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _enteredName = newValue!,
                ),
                //first row....
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      //quantity...
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Quantity"),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: _enteredQuantity.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0 ||
                              value.trim().length <= 1 ||
                              value.trim().length > 50) {
                            return "Must be valid Positive Number  ";
                          }
                          return null;
                        },
                        onSaved: (newValue) =>
                            _enteredQuantity = int.parse(newValue!),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      //drop Down item.....
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items: [
                          //looping through categories Map
                          for (final category in categoriesMap.entries)
                            //customize the Dropdown menu items...
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(category.value.title)
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text("Reset"),
                    ),
                    ElevatedButton(
                      onPressed: _saveItem,
                      child: const Text("Add Item"),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
