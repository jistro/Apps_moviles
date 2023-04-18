import 'package:flutter/material.dart';

class Birthdays extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Icon(
            Icons.cake,
            size: 150.0,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}