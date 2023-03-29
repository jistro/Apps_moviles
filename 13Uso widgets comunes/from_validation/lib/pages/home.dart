import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Order _order = Order();

  String? _validateItemRequired(String value) {
    return value.isEmpty ? 'Item Required' : null;
  }

  String? _validateItemCount(String? value) {
    int? _valueAsInteger = value?.isEmpty ?? true ? 0 : int.tryParse(value!);
    return _valueAsInteger == 0 ? 'At least one Item is Required' : null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState?.validate() ?? false) {
      _formStateKey.currentState?.save();
      print('Order Item: ${_order.item}');
      print('Order Quantity: ${_order.quantity}');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: SafeArea(
        child: Form(
          key: _formStateKey,
          autovalidate: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Espresso',
                    labelText: 'Item',
                  ),
                  validator: (value) => _validateItemRequired(value ?? ''),
                  onSaved: (value) => _order.item = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '1',
                    labelText: 'Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateItemCount,
                  onSaved: (value) => _order.quantity = int.tryParse(value ?? '') ?? 0,
                ),
                Divider(height: 32.0,),
                RaisedButton(
                  child: Text('Save'),
                  color: Colors.lightGreen,
                  onPressed: () => _submitOrder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Order {
  String item;
  int quantity = 0; // default value

  Order({this.item = '', this.quantity = 0});

  // ...
}

