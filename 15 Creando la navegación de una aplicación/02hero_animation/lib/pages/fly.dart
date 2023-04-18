import 'package:flutter/material.dart';

class Fly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.shortestSide / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fly'),
      ),
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: 'format_paint',
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.format_paint,
                color: Colors.blue,
                size: _width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}