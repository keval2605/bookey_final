import 'package:flutter/material.dart';

class Constants {
  static String appName = 'Bookey';

  static const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(12.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  );
}
