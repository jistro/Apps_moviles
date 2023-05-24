import 'package:flutter/material.dart';
import 'package:infoexpenses/data/base_datos.dart';
import '../datetime/datetime_helper.dart';
import '../models/items_gastos.dart';

class GastosData  extends ChangeNotifier{
  
  // lista de gastos
  List<ItemGastos> listOverallExpenses = [];
  double totalExpenses = 0.0;

  List<ItemGastos> getAllExpenses() {
    return listOverallExpenses;
  }

  final bd = HiveDatabase();
  void prepareData() {
    if (bd.leerGasto().isNotEmpty) {
      listOverallExpenses = bd.leerGasto();
    } else {
      listOverallExpenses = [];
    }

    
  }

  // agregar gasto
  void addNewExpense(ItemGastos gasto) {
    listOverallExpenses.add(gasto);
    notifyListeners();
    bd.guardarGasto(listOverallExpenses);
  }

  // eliminar gasto

  void deleteExpense(ItemGastos gasto) {
    listOverallExpenses.remove(gasto);
    notifyListeners();
    bd.eliminarGasto(gasto);
  }

  // editar gasto
  void editExpense(ItemGastos gastoviejo, ItemGastos gastoEditado) {
    listOverallExpenses.remove(gastoviejo);
    listOverallExpenses.add(gastoEditado);
    bd.editarGasto(gastoviejo, gastoEditado);
    notifyListeners();
  }

  // obtener todo el gasto total
  double getTotalExpenses() {
    totalExpenses = 0.0;

    for (var expense in listOverallExpenses) {
      double amount = double.parse(expense.amount);
      totalExpenses += amount;
    }
    return totalExpenses;
  }


  // obtener dia de la semana
  String getDayName(DateTime dateTime){
    switch (dateTime.weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miercoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sabado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  // obtener inicio de la semana (lunes)
  DateTime getStartOfWeek(){

    // obten dia de hoy
    DateTime today = DateTime.now();
  
    DateTime? startOfWeek;

    
    // ve de reversa hasta el lunes
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Lunes') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  Map<String,double> calculateDalyExpenseSumary(){
    Map<String,double> dalyExpenseSumary = {
      // date (ddmmyyyy) : amountTotalForDay
    };

    for (var expense in listOverallExpenses) {
      String date = convertDateTimeToString(expense.dateTime??DateTime.now());
      double amount = double.parse(expense.amount);
      
      if (dalyExpenseSumary.containsKey(date)) {
        double currentAmount = dalyExpenseSumary[date]!;
        currentAmount += amount;
        dalyExpenseSumary[date] = currentAmount;  
      } else {
        dalyExpenseSumary.addAll({date: amount});
      }
    }
    return dalyExpenseSumary;
  }

}