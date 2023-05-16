import 'package:flutter/material.dart';

class ExpenseTitle extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  const ExpenseTitle({
    Key? key,
    required this.name,
    required this.amount,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle:  Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
      trailing: Text('\$ ${amount}'),
    );
  }
}