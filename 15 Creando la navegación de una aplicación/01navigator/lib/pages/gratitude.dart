import 'package:flutter/material.dart';

class Gratitude extends StatefulWidget {
  final int radioGroupValue;

  Gratitude({required this.radioGroupValue});

  @override
  _GratitudeState createState() => _GratitudeState();
}

class _GratitudeState extends State<Gratitude>{
  List<String> _gratitudeList = [];


  String _selectedGratitude = '';
  int _radioGroupValue = -1;

  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
      _selectedGratitude = _gratitudeList[index];
      print('_selectedRadioValue: $_selectedGratitude');
    });
  }

  @override
  void initState() {
    super.initState();

    _gratitudeList..add('Family')..add('Friends')..add('Coffe');
    _radioGroupValue = widget.radioGroupValue;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Gratitude'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Navigator.pop(context, _selectedGratitude),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children:  <Widget>[
              Radio(
                value: 0,
                groupValue: _radioGroupValue,
                onChanged: (int? index) => _radioOnChanged(index!),
              ),
              Text('Family'),
              Radio(
                value: 1,
                groupValue: _radioGroupValue,
                onChanged: (int? index) => _radioOnChanged(index!),
              ),
              Text('Friends'),
              Radio(
                value: 2,
                groupValue: _radioGroupValue,
                onChanged: (int? index) => _radioOnChanged(index!),
              ),
              Text('Coffe'),
            ],
          )
        ),
      ),
    );
  }
}