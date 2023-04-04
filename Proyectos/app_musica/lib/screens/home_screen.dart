import 'package:app_musica/models/song_model.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Song>> songs = Song.loadSongsFromDirectory('/ruta/donde/se/encuentran/las/canciones');
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2e2e2e), Color(0xff000000)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppBar(),
        bottomNavigationBar: const _BotomNavegationBar(),
        body: SingleChildScrollView(
          child: Column(
            children:[
              const _search(),
              Column(
                children: [
                  //continuar 10 21
                  // https://www.youtube.com/watch?v=12ktVNkKw5w&t=570s

                ],
              ),
            ]
          ),
        ),  
      ),
    );
  }
}

class _search extends StatelessWidget {
  const _search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Buscar',
              hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}

class _BotomNavegationBar extends StatelessWidget {
  const _BotomNavegationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar( 
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
        icon: Icon(Icons.home), 
        label: 'Home'),
        BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline_rounded), 
        label: 'Favorites'),
        BottomNavigationBarItem(
        icon: Icon(Icons.play_arrow_outlined), 
        label: 'Play'),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.menu_rounded),
          const SizedBox(width: 10),
          Text(
          'Bienvenido',
          style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          
        ],
      ),
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}