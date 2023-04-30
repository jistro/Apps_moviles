import 'package:flutter/material.dart';
 class GridIcons {
  List <IconData> iconList = [];
  List <IconData> getIconList(){
    iconList 
      ..add(Icons.free_breakfast)
      ..add(Icons.access_alarm)
      ..add(Icons.directions_car)
      ..add(Icons.directions_bike)
      ..add(Icons.directions_boat)
      ..add(Icons.directions_bus)
      ..add(Icons.directions_railway)
      ..add(Icons.star)
      ..add(Icons.face)
      ..add(Icons.favorite)
      ..add(Icons.directions_walk)
      ..add(Icons.directions_run)
      ..add(Icons.directions_subway)
      ..add(Icons.directions_transit)
      ..add(Icons.event_seat)
      ..add(Icons.flight)
      ..add(Icons.hotel)
      ..add(Icons.local_airport)
      ..add(Icons.local_atm)
      ..add(Icons.local_bar);
    return iconList;
  }
}