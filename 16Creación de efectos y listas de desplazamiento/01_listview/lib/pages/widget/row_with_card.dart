import 'package:flutter/material.dart';

class RowWithCardWidget extends StatelessWidget {
  final int index;

  const RowWithCardWidget({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print('Tapped on Row $index');
        },
        child: ListTile(
          leading: Icon(
            Icons.flight,
            size: 48.0,
            color: Colors.lightBlue,
          ),
          title: Text('Airplane $index'),
          subtitle: Text('Cool 👍'),
          trailing: Text(
            '${index * 7}%',
            style: TextStyle(
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
}
