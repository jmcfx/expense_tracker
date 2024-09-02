import 'package:expense_tracker/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpenseModal extends StatefulWidget {
  const NewExpenseModal({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpenseModal> createState() => _NewExpenseModalState();
}

class _NewExpenseModalState extends State<NewExpenseModal> {
  //text Editing controllers....
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  //selectedDate .....
  DateTime? _selectedDate;

  //selectedCategory....
  CategoryEvent _selectedCategory = CategoryEvent.leisure;

  //date picker...
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 2,
      now.month,
      now.day,
    );
    // pickedDate.....
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //submitExpense Data
  void _saveExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      //show error message... showDialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a valid tittle, amount, date and category was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('okay'),
            )
          ],
        ),
      );
      return;
    }

    ///
    widget.onAddExpense(
      ExpenseModel(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //.... if the Width is greater or equal to 600..
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                       //title......
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(label: Text("Title")),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        //amount......
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            prefixText: "\$",
                            label: Text("Amount"),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  )
                  //if the width is less than 600...
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                 if(width >= 600) 
                  Row(
                  children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: CategoryEvent.values
                            .map((categoryValues) => DropdownMenuItem(
                                  value: categoryValues,
                                  child:
                                      Text(categoryValues.name.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (categoryValues) {
                          if (categoryValues == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = categoryValues;
                          });
                        },
                      ),
                     const  SizedBox(width: 24,),
                     Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? "No Selected Date"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                  ],
                 )
                 else
                Row(
                  children: [
                    Expanded(
                      //amount......
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          prefixText: "\$",
                          label: Text("Amount"),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? "No Selected Date"
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if(width >= 600)
                Row(children: [
                    const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _saveExpenseData,
                        child: const Text("Save Expense"),
                      )
                ],)
                else
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: CategoryEvent.values
                          .map((categoryValues) => DropdownMenuItem(
                                value: categoryValues,
                                child: Text(categoryValues.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (categoryValues) {
                        if (categoryValues == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = categoryValues;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _saveExpenseData,
                      child: const Text("Save Expense"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
