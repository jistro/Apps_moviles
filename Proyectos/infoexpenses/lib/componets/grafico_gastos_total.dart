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

  double calcularMaximo(
    GastosData value,
    String lunes,
    String martes,
    String miercoles,
    String jueves,
    String viernes,
    String sabado,
    String domingo,
  ) {
    double? maximo = 0.0;

    List<double> values = [
      value.calculateDalyExpenseSumary()[lunes] ?? 0,
      value.calculateDalyExpenseSumary()[martes] ?? 0,
      value.calculateDalyExpenseSumary()[miercoles] ?? 0,
      value.calculateDalyExpenseSumary()[jueves] ?? 0,
      value.calculateDalyExpenseSumary()[viernes] ?? 0,
      value.calculateDalyExpenseSumary()[sabado] ?? 0,
      value.calculateDalyExpenseSumary()[domingo] ?? 0,
    ];

    values.sort();

    maximo = values.last*1.1;

    return maximo == 0.0 ? 100 : maximo;
  }


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
      Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: GraficoDeBarras(
              maxY: calcularMaximo(
                value,
                lunes,
                martes,
                miercoles,
                jueves,
                viernes,
                sabado,
                domingo,
              ),
                lunCantidad: (value.calculateDalyExpenseSumary()[lunes] ?? 0).clamp(0, double.infinity),
                marCantidad: (value.calculateDalyExpenseSumary()[martes] ?? 0).clamp(0, double.infinity),
                mieCantidad: (value.calculateDalyExpenseSumary()[miercoles] ?? 0).clamp(0, double.infinity),
                jueCantidad: (value.calculateDalyExpenseSumary()[jueves] ?? 0).clamp(0, double.infinity),
                vieCantidad: (value.calculateDalyExpenseSumary()[viernes] ?? 0).clamp(0, double.infinity),
                sabCantidad: (value.calculateDalyExpenseSumary()[sabado] ?? 0).clamp(0, double.infinity),
                domCantidad: (value.calculateDalyExpenseSumary()[domingo] ?? 0).clamp(0, double.infinity),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Presupuesto total',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // total de gastos el formato es $ 00.00 si es negativo se pone en rojo y el formato es -$00.00
          Text(
            value.getTotalExpenses().toString().startsWith('-')
                ? '-\$${value.getTotalExpenses().toString().substring(1)}'
                : '\$${value.getTotalExpenses()}',
            style: TextStyle(
              fontSize: 20,
              color: value.getTotalExpenses().toString().startsWith('-')
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ],
      ),
  );
  }
}