import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget tree"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _buildHorizontalRow(),
                Padding(padding: EdgeInsets.all(16.0),),
                _buildRowAndColumn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildRowAndColumn() {
    return Row(
                children: <Widget>[
                  Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        color: Colors.yellow,
                        height: 40.0,
                        width: 40.0,
                      ),
                      Padding(padding: EdgeInsets.all(16.0),),
                      Container(
                        color: Colors.amber,
                        height: 40.0,
                        width: 40.0,
                      ),
                      Padding(padding: EdgeInsets.all(16.0),),
                      Container(
                        color: Colors.brown,
                        height: 20.0,
                        width: 20.0,
                      ),
                      Divider(),
                      _buildRowAndStack(),
                      Divider(),
                      Text('End of the line'),
                    ],
                  ),
                ],
              );
  }

  Row _buildRowAndStack() {
    return Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.lightGreen,
                          radius: 100.0,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.yellow,
                              ),
                              Container(
                                height: 60.0,
                                width: 60.0,
                                color: Colors.amber,
                              ),
                              Container(
                                height: 40.0,
                                width: 40.0,
                                color: Colors.brown,
                              ),
                            ]
                          )
                        ),
                      ],
                    );
  }

  Row _buildHorizontalRow() {
    return Row(
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    height: 40.0,
                    width: 40.0,
                  ),
                  Padding(padding: EdgeInsets.all(16.0),),
                  Expanded(
                    child: Container(
                      color: Colors.amber,
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(16.0),),
                  Container(
                    color: Colors.brown,
                    height: 40.0,
                    width: 40.0,
                  ),
                ],
              );
  }
}
