import 'package:flutter/material.dart';
import 'menu_list_title.dart';

class LeftDrawerWidget extends StatelessWidget {
  const LeftDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'John Doe',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            accountEmail: Text(
              'johndoe@doamin.com',
              style: TextStyle(
                color: Colors.black,
              ),
              ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                child: Text('JD'),
              ),
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const MenuListTitleWidget(), // calling the function directly
        ],
      ),
    );
  }
}
