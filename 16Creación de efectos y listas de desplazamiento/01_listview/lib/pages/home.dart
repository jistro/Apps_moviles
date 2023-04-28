import 'package:flutter/material.dart';
import 'package:starter_exercise/pages/widget/header.dart';
import 'package:starter_exercise/pages/widget/row.dart';
import 'package:starter_exercise/pages/widget/row_with_card.dart';

import 'package:flutter/material.dart';
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
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0){
              return HeaderWidget(index: index);
            }
            else if (index >= 1 && index <= 3) {
              return RowWithCardWidget(index: index);
            }
            else {
              return RowWidget(index: index);
            }
          },
        ),
      ),
    );
  }
}