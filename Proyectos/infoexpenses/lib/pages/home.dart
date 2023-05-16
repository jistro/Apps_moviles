import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infoexpenses/componets/gastos_title.dart';
import 'package:infoexpenses/componets/grafico_gastos_total.dart';
import 'package:infoexpenses/data/gastos_data.dart';
import 'package:provider/provider.dart';
import 'package:infoexpenses/componets/gastos_title.dart';

import '../models/items_gastos.dart';
class Home extends StatefulWidget 
{
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> 
{
  @override
  Widget build(BuildContext context) 
  {
    // text controller
    final newExpenseNameController = TextEditingController();
    final newExpenseAmountController = TextEditingController();

    void clearControllers(){
      newExpenseNameController.clear();
      newExpenseAmountController.clear();
    }

    void save(){
      ItemGastos newExpense = ItemGastos(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        date: DateTime.now().toString(),
      );
      Provider.of<GastosData>(context, listen: false).addNewExpense(newExpense);
      Navigator.pop(context);
      clearControllers();
    }

    void cancel(){
      Navigator.pop(context);
      clearControllers();
    }
    
    
    // agergar gasto
    void addNewExpense() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical( 
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.brown.shade50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: newExpenseNameController,
                      decoration: InputDecoration(
                        hintText: 'Nombre del gasto',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: newExpenseAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Cantidad',
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          child: const Text('Guardar'),
                          onPressed: save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          child: const Text('Cancelar'),
                          onPressed: cancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade500,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    

    return Consumer<GastosData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.brown.shade50,
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
          ),
          
          body: ListView(children:[
            //GraficoTotal(inicioSemana: value.getStartOfWeek(),),
            Container(
              margin: const EdgeInsets.all(10.0),
              height: 200.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Column( children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: GraficoTotal(inicioSemana: value.getStartOfWeek()),
                  ),
                  
                  Text(
                    'Gasto total: \$ ${value.getTotalExpenses()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenses().length,
              itemBuilder: (context, index) => ExpenseTitle(
                name: value.getAllExpenses()[index].name,
                amount: value.getAllExpenses()[index].amount,
                dateTime: DateTime.parse(value.getAllExpenses()[index].date),
              ),
            ),
        ],),
      ),
    );
  }
}