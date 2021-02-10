import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String _title;
  final Function _clickHandler;

  const AdaptiveTextButton(this._title, this._clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(_title), onPressed: _clickHandler)
        : TextButton(
            onPressed: _clickHandler,
            child: Text(
              _title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
