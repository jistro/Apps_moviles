import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../../provider/song_model_provider.dart';
import 'NowPlaying.dart';

class AllSongs extends StatefulWidget {
  final String artistNameNP;
  final String songNameNP;
  final bool statusPlayNP;

  const AllSongs({
    Key? key,
      required this.artistNameNP,
      required this.songNameNP,
      required this.statusPlayNP,
    }) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  
  bool _flagIsPlayingOutside = false;
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

      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                  height: 40.0,
                  width: 40.0,
                  color: const Color(0xFF9063CD),
                  child: const Icon(Icons.music_note_rounded, color: Colors.white,)
            ),
            const SizedBox(width: 10.0,),
            Row(
              children: [
                Text(widget.songNameNP),
                Text(widget.artistNameNP),
              ],
            ),
            
            IconButton( onPressed: () {
              if (widget.statusPlayNP == false) {
                _audioPlayer.play();
                _flagIsPlayingOutside = true;
              } else {
                _audioPlayer.pause();
                  _flagIsPlayingOutside = false;
              }
            }, icon: Icon(_flagIsPlayingOutside ? Icons.pause_rounded  : Icons.play_arrow), ),
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
                    //q: como agregar numero de track y titulo en el mismo Text?
                    //a: usar TextSpan
                    //q: me enseñas como?
                    //a: https://api.flutter.dev/flutter/widgets/TextSpan-class.html
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