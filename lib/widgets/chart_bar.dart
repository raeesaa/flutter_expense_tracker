import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(children: [
        Container(
          height: constraint.maxHeight * 0.13,
          child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(2)}'),
          ),
        ),
        Container(
          margin: EdgeInsets.all(constraint.maxHeight * 0.02),
          height: constraint.maxHeight * 0.7,
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
        Container(
          height: constraint.maxHeight * 0.13,
          child: FittedBox(child: Text(label)),
        ),
      ]);
    });
  }
}
