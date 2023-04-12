import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../../provider/song_model_provider.dart';
import 'NowPlaying.dart';
class AllSongs extends StatefulWidget {

  const AllSongs({
    Key? key,
    }) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  
  bool _FlagIsPlaying = false;
  List<SongModel> allSongs = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
  }
  requestPermission() async {
    if (Platform.isAndroid) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Bienvenido',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton( onPressed: () {}, icon: const Icon(Icons.search), ),
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
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Cargando...")
                ],
              ),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text('No se encontro ninguna cancion :c'));
          }
          return Stack(
            children:[ 
              
              ListView.builder(
                itemCount: item.data!.length,
                
                itemBuilder: (context, index) {
                  allSongs.addAll(item.data!);
                  
                  return ListTile(
                    title: Text(allSongs[index].title),
                    subtitle: Text(allSongs[index].artist == "<unknown>" ? "Desconocido": allSongs[index].artist.toString()),
                    trailing: const Icon(Icons.more_vert),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(03.0),//or 15.0
                      child: _iconAlbum(item, index),
                    ),
                    onTap: () {
                      
                      context
                          .read<SongModelProvider>()
                          .setId(item.data![index].id);
                      setState(() {
                        _FlagIsPlaying = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(
                                songModelList: [allSongs[index], ...allSongs],
                                audioPlayer: _audioPlayer
                                )));
                    },
                  );
                },
              ),
              _songNowPlayingBar()
            ],
          );
        },
      ),
    );
  }

  Align _songNowPlayingBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60.0,
        width: double.infinity,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                _audioPlayer.seekToPrevious();
              }, 
              icon: const Icon(Icons.skip_previous), iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                if (_audioPlayer.playing == false) {
                  _audioPlayer.play();
                  setState(() {
                    _FlagIsPlaying = true;
                  });
                } else {
                  _audioPlayer.pause();
                  setState(() {
                    _FlagIsPlaying = false;
                  });
                }
              }, 
              icon: Icon(_audioPlayer.playing ? Icons.pause : Icons.play_arrow),
              iconSize: 40,
            ),
            IconButton(
              onPressed: () {
                _audioPlayer.seekToNext();
              }, 
              icon: const Icon(Icons.skip_next), iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }



  Container _iconAlbum(AsyncSnapshot<List<SongModel>> item, int index) {
    return Container(
                  height: 40.0,
                  width: 40.0,
                  color: const Color(0xFF9063CD),
                  child: QueryArtworkWidget(
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note),
                  artworkBorder: BorderRadius.circular(03.0),
                ),
                );
  }
}