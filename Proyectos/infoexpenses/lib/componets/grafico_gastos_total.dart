import 'package:flutter/material.dart';
import 'package:infoexpenses/datetime/datetime_helper.dart';
import 'package:infoexpenses/graph/grafico_bar.dart';
import 'package:provider/provider.dart';

import '../data/gastos_data.dart';

class GraficoTotal extends StatelessWidget {
  final DateTime inicioSemana;
  const GraficoTotal({
    super.key,
    required this.inicioSemana,
    });

  @override
  Widget build(BuildContext context) {
    String lunes = convertDateTimeToString(inicioSemana.add(const Duration(days: 0)));
    String martes = convertDateTimeToString(inicioSemana.add(const Duration(days: 1)));
    String miercoles = convertDateTimeToString(inicioSemana.add(const Duration(days: 2)));
    String jueves = convertDateTimeToString(inicioSemana.add(const Duration(days: 3)));
    String viernes = convertDateTimeToString(inicioSemana.add(const Duration(days: 4)));
    String sabado = convertDateTimeToString(inicioSemana.add(const Duration(days: 5)));
    String domingo = convertDateTimeToString(inicioSemana.add(const Duration(days: 6)));
    return Consumer<GastosData>(
      builder: (context, value, child) =>
      SizedBox(
        height: 150,
        child: GraficoDeBarras(
          maxY: value.getTotalExpenses(),
          lunCantidad: value.calculateDalyExpenseSumary()[lunes] ?? 0,
          marCantidad: value.calculateDalyExpenseSumary()[martes] ?? 0,
          mieCantidad: value.calculateDalyExpenseSumary()[miercoles] ?? 0,
          jueCantidad: value.calculateDalyExpenseSumary()[jueves] ?? 0,
          vieCantidad: value.calculateDalyExpenseSumary()[viernes] ?? 0,
          sabCantidad: value.calculateDalyExpenseSumary()[sabado] ?? 0,
          domCantidad: value.calculateDalyExpenseSumary()[domingo] ?? 0,
        ),
      ),
  );
  }
}