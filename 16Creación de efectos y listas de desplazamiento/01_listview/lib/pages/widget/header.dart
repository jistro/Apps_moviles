import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final int index;
  
  const HeaderWidget({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 120.0,
      child: Card(
        elevation: 8.0,
        color: Colors.white,
        //shape: StadiumBorder(),
        //shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        //shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Barista',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            Text(
              'Coffee Shop',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ],
        ),
      )
    );
  }
}