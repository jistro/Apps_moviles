import 'package:flutter/material.dart';

class SliverGridWidget extends StatelessWidget {
  const SliverGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.child_friendly,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  Divider(),
                  Text('Grid ${index + 1}'),
                ],
              ),
            );
          },
          childCount: 12,
        ),
      ),
    );
  }
}
