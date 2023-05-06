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
        title: Text(
            'Layouts',
            style: TextStyle(
              color: Colors.black87
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black87
          ),
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_queue),
              onPressed: (){},
            )
          ],
      ),
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _buildJournalHeaderImage(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildJournalEntry(),
                Divider(),
                _buildJournalWeather(),
                Divider(),
                _buildJournalTags(),
                Divider(),
                _buildJournalFooterImages(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Image _buildJournalHeaderImage() {
  return Image.asset(
    'assets/images/present.jpg',
    fit: BoxFit.cover,
  );
}

Column _buildJournalEntry() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'My birthday :)',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(),
      Text(
        'Today is my 27th birthday. We going out for dinner at my favorite restaurant and I am so excited!',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    ],
  );
}

Row _buildJournalWeather() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.wb_sunny,
            color: Colors.orange,
          ),
        ],
      ),
      SizedBox(
        width: 16.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '81° Clear skies',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '30147 Windy Hill Road',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  );
}

Wrap _buildJournalTags() {
  return Wrap(
    spacing: 8.0,
    children: List.generate(
      6,
      (int index) {
        return Chip(
          label: Text(
            'Gift ${index + 1}',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
          avatar: Icon(
            Icons.card_giftcard,
            color: Colors.blue.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: Colors.grey,
            ),
          ),
          backgroundColor: Colors.grey.shade100,
        );
      },
    ),
  );
}

Row _buildJournalFooterImages(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/salmon.jpg'),
      ),
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/asparagus.jpg'),
      ),
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/strawberries.jpg'),
      ),
      SizedBox(
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.cake,
              color: Colors.pink,
            ),
            Icon(
              Icons.star_border,
              color: Colors.grey,
            ),
            Icon(
              Icons.music_note,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    ],
  );
}