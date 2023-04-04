import 'package:app_musica/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_musica/screens/playlist_screen.dart';
import 'package:app_musica/screens/screens.dart';
import 'package:app_musica/screens/home_screen.dart';
import 'package:app_musica/screens/song_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Musica',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
        ),
      ),
      home: const HomeScreen(), 
      getPages: [
        GetPage(name: '/',         page: () => const HomeScreen()),
        GetPage(name: '/song',     page: () => const SongScreen()),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
      ],
    );
  }
}