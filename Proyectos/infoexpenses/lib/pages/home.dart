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
  DateTime fechaAElegir = DateTime.now();

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
    // date controller
    

    void clearControllers(){
      newExpenseNameController.clear();
      newExpenseAmountController.clear();
    }

    void changeDate() async{
      // cambiar fecha
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaAElegir,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != fechaAElegir)
        setState(() {
          fechaAElegir = DateTime(picked.year, picked.month, picked.day, fechaAElegir.hour, fechaAElegir.minute);
        });

    }

    void timeChange () async{
      // cambiar hora
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null)
        setState(() {
          fechaAElegir = DateTime(fechaAElegir.year, fechaAElegir.month, fechaAElegir.day, picked.hour, picked.minute);
      });
    }

    void saveExpense() {
      // guarda en una variable auxiliar el getTotalExpenses()
      // guardar solo si todo esta lleno
      if (newExpenseAmountController.text.isNotEmpty &&
          newExpenseNameController.text.isNotEmpty &&
          double.parse(newExpenseAmountController.text) > 0 &&
          Provider.of<GastosData>(context, listen: false).getTotalExpenses()  > 0 &&
          double.parse(newExpenseAmountController.text) <= Provider.of<GastosData>(context, listen: false).getTotalExpenses()
          
          
          ) {
        double amount = double.parse(newExpenseAmountController.text) * -1;

        ItemGastos newExpense = ItemGastos(
          name: newExpenseNameController.text,
          amount: amount.toString(),
          date: fechaAElegir,
        );

        Provider.of<GastosData>(context, listen: false).addNewExpense(newExpense);
      }
      Navigator.pop(context);
      fechaAElegir = DateTime.now();
      clearControllers();
    }
    void saveIncome(){
      // guardar solo si todo esta lleno
      if (newExpenseAmountController.text.isNotEmpty && newExpenseNameController.text.isNotEmpty)
      {
        ItemGastos newExpense = ItemGastos(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          date: fechaAElegir,
        );
        Provider.of<GastosData>(context, listen: false).addNewExpense(newExpense);
      }
      Navigator.pop(context);
      fechaAElegir = DateTime.now();
      clearControllers();
    }


    void cancel(){
      Navigator.pop(context);
      fechaAElegir = DateTime.now();
      clearControllers();
    }

    void delete(ItemGastos gasto){
      // si getTotalExpenses() - gasto a eliminar es menor a 0 no se puede eliminar
      if (Provider.of<GastosData>(context, listen: false).getTotalExpenses() - double.parse(gasto.amount) >= 0)
      {
        Provider.of<GastosData>(context, listen: false).deleteExpense(gasto);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Eliminado'),
          ),
        );
        
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se puede eliminar'),
          ),
        );
      }
      
    }

    void edit(ItemGastos gastoViejo, ItemGastos gastoEditado){
      Provider.of<GastosData>(context, listen: false).deleteExpense(gastoViejo);
      Provider.of<GastosData>(context, listen: false).addNewExpense(gastoEditado);
      Navigator.pop(context);
      clearControllers();
    }

    
    // agergar gasto nuevo
    void addNewExpense() {
      fechaAElegir = DateTime.now();
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
              height: 250,
              color: Colors.brown.shade50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  // seccion de fecha y hora
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              //agregamos icono de calendario junto con la fecha
                              onPressed: changeDate,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today),
                                  Text('  ${fechaAElegir.day}/${fechaAElegir.month}/${fechaAElegir.year}'),
                                ],
                              ),
                              
                              style: ElevatedButton.styleFrom(
                                // debe ser invisible
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              //agregamos icono de calendario junto con la fecha
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time),
                                  Text('  ${fechaAElegir.hour}:${fechaAElegir.minute}'),
                                ],
                              ),
                              onPressed: timeChange,
                              style: ElevatedButton.styleFrom(
                                // debe ser invisible
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // boton de guardar y cancelar
                  const SizedBox(height: 10),
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
              height: 250,
              color: Colors.brown.shade50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 15),
                  // seccion de fecha y hora
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              //agregamos icono de calendario junto con la fecha
                              onPressed: changeDate,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today),
                                  Text('  ${fechaAElegir.day}/${fechaAElegir.month}/${fechaAElegir.year}'),
                                ],
                              ),
                              
                              style: ElevatedButton.styleFrom(
                                // debe ser invisible
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              //agregamos icono de calendario junto con la fecha
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time),
                                  Text('  ${fechaAElegir.hour}:${fechaAElegir.minute}'),
                                ],
                              ),
                              onPressed: timeChange,
                              style: ElevatedButton.styleFrom(
                                // debe ser invisible
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // boton de guardar y cancelar
                  const SizedBox(height: 10),
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