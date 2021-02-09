import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final String _title;
  final Function _clickHandler;

  AdaptiveElevatedButton(this._title, this._clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(child: Text(_title), onPressed: _clickHandler)
        : ElevatedButton(
            onPressed: _clickHandler,
            child: Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
