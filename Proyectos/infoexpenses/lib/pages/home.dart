import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:infoexpenses/componets/gastos_title.dart';
import 'package:infoexpenses/componets/grafico_gastos_total.dart';
import 'package:infoexpenses/data/gastos_data.dart';
import 'package:provider/provider.dart';


import '../models/items_gastos.dart';
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<GastosData>(context, listen: false).prepareData();
  }

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

    void saveExpense() {
      // guardar solo si todo esta lleno
      if (newExpenseAmountController.text.isNotEmpty &&
          newExpenseNameController.text.isNotEmpty &&
          double.parse(newExpenseAmountController.text) > 0
          ) {
        double amount = double.parse(newExpenseAmountController.text) * -1;

        ItemGastos newExpense = ItemGastos(
          name: newExpenseNameController.text,
          amount: amount.toString(),
          date: DateTime.now(),
        );

        Provider.of<GastosData>(context, listen: false).addNewExpense(newExpense);
      }
      Navigator.pop(context);
      clearControllers();
    }
    void saveIncome(){
      // guardar solo si todo esta lleno
      if (newExpenseAmountController.text.isNotEmpty && newExpenseNameController.text.isNotEmpty)
      {
        ItemGastos newExpense = ItemGastos(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          date: DateTime.now(),
        );
        Provider.of<GastosData>(context, listen: false).addNewExpense(newExpense);
      }
      Navigator.pop(context);
      clearControllers();
    }


    void cancel(){
      Navigator.pop(context);
      clearControllers();
    }

    void delete(ItemGastos gasto){
      Provider.of<GastosData>(context, listen: false).deleteExpense(gasto);
    }

    void edit(ItemGastos gastoViejo, ItemGastos gastoEditado){
      Provider.of<GastosData>(context, listen: false).deleteExpense(gastoViejo);
      Provider.of<GastosData>(context, listen: false).addNewExpense(gastoEditado);
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
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
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
                            onPressed: saveExpense,
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
            ),
          );
        },
      );
    }

    void addNewIncome() {
      showModalBottomSheet(
        
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical( 
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
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
                          hintText: 'Nombre del ingreso',
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
                            onPressed: saveIncome,
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
            ),
          );
        },
      );
    }

    void editExpense(ItemGastos gastoViejo){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Editar gasto'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: newExpenseNameController,
                    decoration: InputDecoration(
                      hintText: 'Nombre del gasto',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  TextField(
                    controller: newExpenseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Cantidad',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            child: const Text('Editar'),
                            onPressed: () => edit(gastoViejo, ItemGastos(
                              name: newExpenseNameController.text,
                              amount: newExpenseAmountController.text,
                              date: DateTime.now(),
                            )),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade500,
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
          );
        },
      );
      //Provider.of<GastosData>(context, listen: false).editExpense(gasto, gastoEditado);
    }

    return Consumer<GastosData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.brown.shade50,
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.black,
            overlayColor: Colors.black,
            overlayOpacity: 0.1,
            children: [
              SpeedDialChild(
                label: 'Agregar gasto',
                child: Icon(Icons.remove),
                backgroundColor: Colors.red.shade200,
                onTap: addNewExpense,
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                label: 'Agregar ingreso',
                backgroundColor: Colors.green.shade200,
                onTap: addNewIncome,
              ),
            ],
          ),
          
          body: ListView(children:[
            //GraficoTotal(inicioSemana: value.getStartOfWeek(),),
            Container(
              margin: const EdgeInsets.all(10.0),
              height: 237.0,
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
              ],),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenses().length,
              itemBuilder: (context, index) => ExpenseTitle(
                name: value.getAllExpenses()[index].name,
                amount: value.getAllExpenses()[index].amount,
                dateTime: value.getAllExpenses()[index].date,
                presionaBorrar: (p0) => delete(value.getAllExpenses()[index]),
                presionaEditar: (p0) => editExpense(value.getAllExpenses()[index]),

              ),
            ),
        ],),
      ),
    );
  }
}