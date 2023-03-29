import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const ImagesAndIconWidget(),
                  Divider(),
                  const BoxDecoratorWidget(),
                  Divider(),
                  const ImputDecoratorWidget(),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

class ImagesAndIconWidget extends StatelessWidget{
  const ImagesAndIconWidget({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image(
          image: AssetImage("assets/images/logo.png"),
          //color: orange,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 3,
          ),
        Image.network(
          'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
          width: MediaQuery.of(context).size.width / 6,
        ),
        Icon(
          Icons.brush,
          color: Colors.lightBlue,
          size: 48.0,
        ),
      ],
    );
  }
}

class BoxDecoratorWidget extends StatelessWidget{
  const BoxDecoratorWidget({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 10.0),
              blurRadius: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ImputDecoratorWidget extends StatelessWidget{
  const ImputDecoratorWidget({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16.0,
          ),
          decoration: InputDecoration(
            labelText: "Notes",
            labelStyle: TextStyle(color: Colors.purple),
            //border: OutlineInputBorder(),
            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)), 
          ),
        ),
        Divider(
          color: Colors.lightGreen,
          height: 50.0,
        ),
        TextFormField(decoration: InputDecoration(labelText: 'Enter your notes')),
      ],
    );
  }
}
