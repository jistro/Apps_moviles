import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
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
  final _audioQuery = new OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  playSong(String? uri) {
    try {
    _audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(uri!),
      ),
    );
    _audioPlayer.play();
    } on Exception catch (e) {
      print("error parsing song: $e");
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
        title: Text('Music Player'),
        actions: [
          IconButton( onPressed: () {}, icon: Icon(Icons.search), ),
        ],
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
          return ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                
                title: Text(item.data![index].title),
                subtitle: Text(item.data![index].artist ?? 'Desconocido'),
                trailing: const Icon(Icons.more_vert),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(03.0),//or 15.0
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    color: Color(0xffFF0E58),
                    child: Icon(Icons.music_note),
                  ),
                ),
                onTap: () {
                  playSong(item.data![index].uri);
                },
              );
            },
          );
        },
      ),
    );
  }
}