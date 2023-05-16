import 'package:infoexpenses/graph/individual_bar.dart';

class BarData{
  final double lunCantidad;
  final double marCantidad;
  final double mieCantidad;
  final double jueCantidad;
  final double vieCantidad;
  final double sabCantidad;
  final double domCantidad;
  
  BarData({
    required this.lunCantidad, 
    required this.marCantidad, 
    required this.mieCantidad, 
    required this.jueCantidad, 
    required this.vieCantidad, 
    required this.sabCantidad, 
    required this.domCantidad
  });

  List<IndividualBar> barData = [];

  void initializeBarData(){
    barData = [
      // lun
      IndividualBar(x: 0, y: lunCantidad),
      // mar
      IndividualBar(x: 1, y: marCantidad),
      // mie
      IndividualBar(x: 2, y: mieCantidad),
      // jue
      IndividualBar(x: 3, y: jueCantidad),
      // vie
      IndividualBar(x: 4, y: vieCantidad),
      // sab
      IndividualBar(x: 5, y: sabCantidad),
      // dom
      IndividualBar(x: 6, y: domCantidad),
      
    ];
  }

}