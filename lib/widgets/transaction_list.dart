import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  const TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.05,
                ),
                Container(
                  height: constraint.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            );
          })
        : ListView(
            children: _userTransactions
                .map(
                  (tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    userTransaction: tx,
                    deleteTransaction: _deleteTransaction,
                  ),
                )
                .toList(),
          );
  }
}
