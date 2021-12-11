import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        child: Text(
          "Something is not right here...",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
      ),
      color: Colors.red,
      margin: EdgeInsets.zero,
    );
  }
}
