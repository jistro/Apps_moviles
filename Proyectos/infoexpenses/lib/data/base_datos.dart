import 'package:hive_flutter/hive_flutter.dart';

import '../models/items_gastos.dart';

class HiveDatabase {
  final _caja = Hive.box('gastos_baseDeDatos');

  void guardarGasto (List<ItemGastos> todosGastos) {

    List<List<dynamic>> listaBienFormada = [];

    for (var gasto in todosGastos) {
      List<dynamic> expenseFormated = [
        gasto.name,
        gasto.amount,
        gasto.date,
      ];
      listaBienFormada.add(expenseFormated);
    }
    _caja.put("TODOS_GASTOS", listaBienFormada);
  }

  List<ItemGastos> leerGasto() {
    List gastosGuardados = _caja.get("TODOS_GASTOS") ?? [];
    List<ItemGastos> todosGastos = [];
    for (int i = 0; i < gastosGuardados.length; i++) {
      String name = gastosGuardados[i][0];
      String amount = gastosGuardados[i][1];
      DateTime date = gastosGuardados[i][2];

      ItemGastos gastoAbiertos = ItemGastos(
        name: name, 
        amount: amount, 
        date: date
      );

      todosGastos.add(gastoAbiertos);
    }
    return todosGastos;
  }

  void eliminarGasto(ItemGastos gasto) {
    List<ItemGastos> todosGastos = leerGasto();
    todosGastos.remove(gasto);
    guardarGasto(todosGastos);
  }

  void editarGasto(ItemGastos gasto, ItemGastos gastoEditado) {
    List<ItemGastos> todosGastos = leerGasto();
    todosGastos.remove(gasto);
    todosGastos.add(gastoEditado);
    guardarGasto(todosGastos);
  }
}