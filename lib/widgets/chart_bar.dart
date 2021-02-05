import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FittedBox(
        child: Text('\$${spendingAmount.toStringAsFixed(2)}'),
      ),
      Container(
        margin: EdgeInsets.all(4),
        height: 80,
        width: 15,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[350],
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPercent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
      Text(label),
    ]);
  }
}
