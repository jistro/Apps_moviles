import 'package:flutter/material.dart';
import 'package:infoexpenses/data/gastos_data.dart';
import 'package:provider/provider.dart';

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
    
    // agergar gasto
    void addNewExpense() {
      showModalBottomSheet(
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
                        hintText: 'Nombre del gastoooo',
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
                          onPressed: (){
                                    ItemGastos newExpense = ItemGastos(
                                      name: newExpenseNameController.text,
                                      amount: newExpenseAmountController.text,
                                      date: DateTime.now().toString(),
                                    );
                                    Provider.of<GastosData>(context, listen: false).addNewExpense(newExpense);
                                  },
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
                          onPressed: () => Navigator.pop(context),
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

    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
      ),

    );
  }
}