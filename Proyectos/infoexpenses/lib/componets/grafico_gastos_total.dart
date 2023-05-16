import 'package:flutter/material.dart';
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
    return Consumer<GastosData>(
      builder: (context, value, child) =>
      SizedBox(
        height: 150,
        child: GraficoDeBarras(
          maxY: 100,
          lunCantidad: 10,
          marCantidad: 45,
          mieCantidad: 85,
          jueCantidad: 60,
          vieCantidad: 30,
          sabCantidad: 20,
          domCantidad: 45,
        ),
      ),
  );
  }
}