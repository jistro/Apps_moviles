import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:infoexpenses/graph/bar_data.dart';

class GraficoDeBarras extends StatelessWidget {
  final double? maxY;
  final double lunCantidad;
  final double marCantidad;
  final double mieCantidad;
  final double jueCantidad;
  final double vieCantidad;
  final double sabCantidad;
  final double domCantidad;

  const GraficoDeBarras({
    Key? key,
    required this.maxY,
    required this.lunCantidad,
    required this.marCantidad,
    required this.mieCantidad,
    required this.jueCantidad,
    required this.vieCantidad,
    required this.sabCantidad,
    required this.domCantidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      lunCantidad: lunCantidad,
      marCantidad: marCantidad,
      mieCantidad: mieCantidad,
      jueCantidad: jueCantidad,
      vieCantidad: vieCantidad,
      sabCantidad: sabCantidad,
      domCantidad: domCantidad,
    );
    myBarData.initializeBarData();
    return BarChart(BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ),
            ),
          ),
        barGroups: myBarData.barData.map(
        (data) => BarChartGroupData(
            x: data.x,
            barRods:[
              BarChartRodData(
                toY: data.y,
                color: Colors.grey.shade800,
                width: 25,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: Colors.brown.shade50,
                ),
              )
            ],
          ),
        ).toList(),
    ),);
  }
}

Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  Widget text;
  switch (value.toInt()){
    case 0:
      text = const Text('L', style: style);
      break;
    case 1:
      text = const Text('M', style: style);
      break;
    case 2:
      text = const Text('X', style: style);
      break;
    case 3:
      text = const Text('J', style: style);
      break;
    case 4:
      text = const Text('V', style: style);
      break;
    case 5:
      text = const Text('S', style: style);
      break;
    case 6:
      text = const Text('D', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
    );
}