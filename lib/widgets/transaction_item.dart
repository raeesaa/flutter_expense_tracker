import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required Transaction userTransaction,
    @required Function deleteTransaction,
  })  : _userTransaction = userTransaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _userTransaction;
  final Function _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const availableColors = [
      Colors.red,
      Colors.teal,
      Colors.cyan,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$${widget._userTransaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget._userTransaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget._userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () =>
                    widget._deleteTransaction(widget._userTransaction.id),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).errorColor),
                ),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget._deleteTransaction(widget._userTransaction.id)),
      ),
    );
  }
}
