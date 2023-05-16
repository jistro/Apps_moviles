import 'package:flutter/material.dart';
import '../datetime/datetime_helper.dart';
import '../models/items_gastos.dart';



class GastosData  extends ChangeNotifier{
  // lista de gastos
  List<ItemGastos> LIST_overallExpenses = [];

  List<ItemGastos> getAllExpenses() {
    return LIST_overallExpenses;
  }

  // agregar gasto
  void addNewExpense(ItemGastos gasto) {
    LIST_overallExpenses.add(gasto);
  }

  // eliminar gasto

  void deleteExpense(ItemGastos gasto) {
    LIST_overallExpenses.remove(gasto);
  }

  // editar gasto
  void editExpense(ItemGastos gasto, ItemGastos gastoEditado) {
    LIST_overallExpenses.remove(gasto);
    LIST_overallExpenses.add(gastoEditado);
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
  DateTime getStartOfWeek(DateTime dateTime){
    DateTime? startOfWeek;

    // obten dia de hoy
    DateTime today = DateTime.now();
  
    // ve de reversa hasta el lunes
    for (int i = 0; i < 1; i++) {
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

    for (var expense in LIST_overallExpenses) {
      String Date = convertDateTimeToString(expense.dateTime!);
      double amount = double.parse(expense.amount);
      
      if (dalyExpenseSumary.containsKey(Date)) {
        double currentAmount = dalyExpenseSumary[Date]!;
        currentAmount += amount;
        dalyExpenseSumary[Date] = currentAmount;  
      } else {
        dalyExpenseSumary.addAll({Date: amount});
      }
    }
    return dalyExpenseSumary;
  }
}