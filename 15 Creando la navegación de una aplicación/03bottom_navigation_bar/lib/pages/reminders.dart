import 'package:flutter/material.dart';

class Reminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Icon(
            Icons.access_alarm,
            size: 150.0,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
