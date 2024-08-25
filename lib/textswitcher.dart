import 'package:flutter/material.dart';
import 'dart:async';

class TextSwitcher extends StatefulWidget {
  @override
  _TextSwitcherState createState() => _TextSwitcherState();
}

class _TextSwitcherState extends State<TextSwitcher> {
  bool _showFirstText = true;

  @override
  void initState() {
    super.initState();
    // Change text after 3 seconds
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showFirstText = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(child: child, opacity: animation);
      },
      child: _showFirstText
          ? Text(
              'Searching...',
              key: ValueKey(1),
              style: TextStyle(fontSize: 24),
            )
          : Text(
              'Abishayan',
              key: ValueKey(2),
              style: TextStyle(fontSize: 24),
            ),
    );
  }
}