import 'package:flutter/material.dart';

class SliverAppBarWidget  extends StatelessWidget {
  const SliverAppBarWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade400,
      forceElevated: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Paralax Effect'),
        background: Image.asset(
          'assets/images/desk.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}