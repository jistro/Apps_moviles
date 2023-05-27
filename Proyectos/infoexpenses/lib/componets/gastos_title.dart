import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTitle extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? presionaBorrar;
  void Function(BuildContext)? presionaEditar;

  ExpenseTitle({
    Key? key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.presionaBorrar,
    required this.presionaEditar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          //borrar
          SlidableAction(
            onPressed: presionaBorrar,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
          //editar
          SlidableAction(
            onPressed: presionaEditar,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        // formato dd/mm/aaaa hh:mm
        subtitle:  Text('${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}'),
        trailing: Text('\$ ${amount}'),
      ),
    );
  }
}