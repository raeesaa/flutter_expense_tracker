import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_text_button.dart';
import './adaptive_elevated_button.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;

  NewTransaction(this.onAddTransaction) {
    print('Contructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('In createState');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  /**
   * Lifecycle methods for stateful widget:
   * 1. createState
   * 2. initState - called only once
   * 3. build() - called multiple times (first time when component is initialized and then on state change / media query change)
   * 4. didUpdateWidget - on state change
   * 5. dispose - when widget is destoyed
   */

  // _NewTransactionState() {
  //   print('Contructor NewTransaction State');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   print('In intState');
  // }

  // @override
  // void didUpdateWidget(covariant NewTransaction oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('In didUpdateWidget');
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   print('In dispose');
  // }

  void _onSubmit() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onAddTransaction(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _onSubmit(),
                // onChanged: (title) => titleInput = title,
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                onSubmitted: (_) => _onSubmit(),
                // onChanged: (amount) => amountInput = amount,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen!'
                            : 'Picked Data: ${DateFormat().add_yMMMMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveTextButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              AdaptiveElevatedButton('Add Transaction', _onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
