import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/provider/song_model_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  final List<SongModel> songModelList;
  final AudioPlayer audioPlayer;

  const NowPlaying({
    Key? key, 
    required this.songModelList, 
    required this.audioPlayer
    }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool _flagIsPlaying = false;
  List<AudioSource> playlist = [];
  int currentSongIndex = 0;

  void popBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      for (var element in widget.songModelList) {
        playlist.add(
          AudioSource.uri(
            Uri.parse(element.uri!),
          ),
        );
      }
    widget.audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: playlist),
      );
    widget.audioPlayer.play();
    _flagIsPlaying = true;

    widget.audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration!;
      });
    });
    widget.audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });
    } on Exception catch (_) {
      popBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
              SizedBox(height: 30.0,),
              Center(
                child: Column(
                  children: [
                    _albumImg(),
                    SizedBox(height: 80.0,),
                    _infoMusicText(),
                    Row(
                      children: [
                        Text('${_position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(_position.inSeconds.remainder(60)).toString().padLeft(2, '0')}'),
                          Expanded(
                            child: Slider(
                              min: 0.0,
                              value: _position.inSeconds.toDouble(), 
                              max: _duration.inSeconds.toDouble()+1,
                              onChanged: (value) {
                                setState(() {
                                  _position = Duration(seconds: value.toInt());
                                  widget.audioPlayer.seek(_position);
                                });
                              }, 
                              activeColor: Color(0xFF9063CD), 
                              inactiveColor: Colors.grey,
                            ),
                          ),
                        Text('${_duration.inHours > 0 ? _duration.inHours.toString().padLeft(2, '0') + ':' : ''}${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(_duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}'),
                      ],
                    ),
                    _interactionsBar()
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  Row _infoMusicText() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                  widget.songModelList[currentSongIndex].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
            SizedBox(height: 5.0),
            Text(
              widget.songModelList[currentSongIndex].artist == "null" ? "Desconocido": widget.songModelList[currentSongIndex].artist.toString(),
              style: const TextStyle(
                          fontSize: 10.0,
                          overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }

  ClipRRect _albumImg() {
    return ClipRRect(
    borderRadius: BorderRadius.circular(03.0),//or 15.0
      child: Container(
        height: 300.0,
        width: 300.0,
        color: Color(0xFF9063CD),
        child: const CoverWidget(),
        //Icon(Icons.music_note, size: 100.0,),
      ),
    );
  }

  Row _interactionsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //repetir
        IconButton(
          onPressed: (){
            
          }, 
          icon: Icon(Icons.repeat), 
          iconSize: 30,
        ),
        //anterior
        IconButton(
          onPressed: (){
            widget.audioPlayer.seekToPrevious();
          }, 
          icon: Icon(Icons.skip_previous), 
          iconSize: 30,
        ),
        //play/pause
        IconButton( 
          onPressed: () {
            setState( () {
                if(_flagIsPlaying){
                  widget.audioPlayer.pause();
                  _flagIsPlaying = false;
                }
                else{
                  widget.audioPlayer.play();
                  _flagIsPlaying = true;
                }
              }
            );
          }, 
          icon: Icon(_flagIsPlaying ? Icons.pause_rounded : Icons.play_arrow), 
          iconSize: 60.0, 
          color: Color(0xFF9063CD),
        ),
        //siguiente
        IconButton(
          onPressed: () {
          
          }, 
          icon: Icon(Icons.skip_next), iconSize: 30,
        ),
        //aleatorio
        IconButton(
          onPressed: (){
            widget.audioPlayer.setShuffleModeEnabled(true);
          }, 
          icon: Icon(Icons.shuffle), 
          iconSize: 30,
        ),
      ],
    );
  }


  
}

class CoverWidget extends StatelessWidget {
  const CoverWidget({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: context.watch<SongModelProvider>().id,
      type: ArtworkType.AUDIO,
      artworkBorder: BorderRadius.circular(03.0),
      artworkFit: BoxFit.cover,
      nullArtworkWidget: Icon(Icons.music_note, size: 100.0,),
    );
  }
}