import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infoexpenses/data/gastos_data.dart';
import 'package:infoexpenses/pages/home.dart';
import 'package:provider/provider.dart';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox('gastos_baseDeDatos');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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