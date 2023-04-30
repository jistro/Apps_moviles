import 'package:flutter/material.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget> [
        Image(
          image: AssetImage('assets/images/tree.jpg'),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/profile1.png'),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Text(
            'User One',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]
    );
  }
}