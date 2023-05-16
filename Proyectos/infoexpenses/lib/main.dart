import 'package:flutter/material.dart';
import 'package:infoexpenses/data/gastos_data.dart';
import 'package:infoexpenses/pages/home.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) 
  {
    return ChangeNotifierProvider(
      
      create: (context) => GastosData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}