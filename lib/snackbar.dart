import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      {SnackBarAction? snackBarAction , Color backgroundColor = const Color.fromARGB(255, 104, 230, 183)}) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        backgroundColor: backgroundColor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
