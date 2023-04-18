import 'package:flutter/material.dart';
import 'package:starter_exercise/pages/fly.dart';
class Home extends StatefulWidget 
{
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Hero(
              tag: 'format_paint',
              child: Icon(
                Icons.format_paint,
                color: Colors.blue,
                size: 120.0,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Fly(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}