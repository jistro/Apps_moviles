import 'package:flutter/material.dart';
import 'package:music_player/Screens/nowPlaying.dart';
import 'package:music_player/provider/song_model_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongModelProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AllSongs(),
    );
  }
}

class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  _AllSongsState createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  playSong(String? uri) {
  if (uri != null) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
      _audioPlayer.play();
    } on Exception {
      print("error parsing song");
    }
  } else {
    print("uri is null");
  }
}

  @override
  void initState() {
    super.initState();
    Permission.storage.request();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Music Player'),
        actions: [
          IconButton( onPressed: () {}, icon: Icon(Icons.search), ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          
          children: [
            
            IconButton( onPressed: () {}, icon: Icon(Icons.home), ),
            IconButton( onPressed: () {}, icon: Icon(Icons.favorite), ),
            IconButton( onPressed: () {}, icon: Icon(Icons.settings), ),
          ],
        ),
      ),
      body: FutureBuilder <List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
      
        
        
        builder: (context, item) {
          if (item.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text('No se encontro ninguna cancion :c'));
          }
          return Stack(
            children:[ 
              ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    
                    title: Text(item.data![index].title),
                    subtitle: Text(item.data![index].artist ?? 'Desconocido'),
                    trailing: const Icon(Icons.more_vert),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(03.0),//or 15.0
                      child: _iconAlbum(item, index),
                    ),
                    onTap: () {
                      context.read<SongModelProvider>().setId(item.data![index].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(
                            songModel: item.data![index],
                            audioPlayer: _audioPlayer,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Container _iconAlbum(AsyncSnapshot<List<SongModel>> item, int index) {
    return Container(
                  height: 40.0,
                  width: 40.0,
                  color: Color(0xFF9063CD),
                  child: QueryArtworkWidget(
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note),
                  artworkBorder: BorderRadius.circular(03.0),
                ),
                );
  }
}