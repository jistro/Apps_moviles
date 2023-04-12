import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music/features/shared/ui/screens/SongsList.dart';
import 'package:music/provider/song_model_provider.dart';
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
  bool _flagIsLooping = false;
  bool _flagIsShuffling = false;
  List<AudioSource> songList = [];

  int currentIndex = 0;
  int indexForSong = 0;

  void popBack() {
    Navigator.pop(context,
                  MaterialPageRoute(
                    builder: (context) => AllSongs(
                      artistNameNP: widget.songModelList[currentIndex].artist.toString(),
                      songNameNP: widget.songModelList[currentIndex].title.toString(),
                      statusPlayNP: _flagIsPlaying,
                    )
                  ),
    );
  }

  void seekToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

  
  

  @override
  void initState() {
    super.initState();
    parseSong();
  }

  

  void parseSong() {
    try {
      for (var element in widget.songModelList) {
        songList.add(
          AudioSource.uri(
            Uri.parse(element.uri!),
            tag: MediaItem(
              id: element.id.toString(),
              album: element.album ?? "No Album",
              title: element.displayNameWOExt,
              artUri: Uri.parse(element.id.toString()),
            ),
          ),
        );
      }
    for (var i = 1; i < widget.songModelList.length; i++) {
      if (widget.songModelList[i].title.toString() == widget.songModelList[0].title.toString()) {
        indexForSong = i;
        break;
      } 
    }
    widget.audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: songList),initialIndex: indexForSong
        
      );


    
    widget.audioPlayer.play();
    _flagIsPlaying = true;

    widget.audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            _duration = duration;
          });
        }
      });

    widget.audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });
      
      listenToEvent();
      listenToSongIndex();
    } on Exception catch (_) {
      popBack();
    }
  }

  
  void listenToEvent() {
    widget.audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        setState(() {
          _flagIsPlaying = true;
        });
      } else {
        setState(() {
          _flagIsPlaying = false;
        });
      }
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _flagIsPlaying = false;
        });
      }
    });
  }

  void listenToSongIndex() {
    widget.audioPlayer.currentIndexStream.listen(
      (event) {
        setState(
          () {
            if (event != null) {
              currentIndex = event;
            }
            context
                .read<SongModelProvider>()
                .setId(widget.songModelList[currentIndex].id);
          },
        );
      },
    );
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
              IconButton(onPressed: (){
                popBack();
              }, icon: const Icon(Icons.arrow_back_ios)),
              const SizedBox(height: 30.0,),
              Flexible(
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    _albumImg(),
                    const SizedBox(height: 80.0,),
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
                                  seekToSeconds(value.toInt());
                                  value = value;
                                });
                              }, 
                              activeColor: const Color(0xFF9063CD), 
                              inactiveColor: Colors.grey,
                            ),
                          ),
                        Text('${_duration.inHours > 0 ? '${_duration.inHours.toString().padLeft(2, '0')}:' : ''}${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(_duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}'),
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
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                    widget.songModelList[currentIndex].title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            overflow: TextOverflow.visible
                            ),
                        maxLines: 1,
                      ),
              const SizedBox(height: 5.0),
              Text(
                widget.songModelList[currentIndex].artist == "<unknown>" ? "Desconocido": widget.songModelList[currentIndex].artist.toString(),
                style: const TextStyle(
                            fontSize: 10.0,
                            overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
            ],
          ),
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
        color: const Color(0xFF9063CD),
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
            if (_flagIsLooping== false){
              widget.audioPlayer.setLoopMode(LoopMode.one);
              _flagIsLooping = true;
            }
            else{
              widget.audioPlayer.setLoopMode(LoopMode.off);
              _flagIsLooping = false;
            }
          }, 
          icon:  Icon(_flagIsLooping  ? Icons.repeat_one_rounded : Icons.repeat_rounded),
          iconSize: 30,
        ),
        //anterior
        IconButton(
          onPressed: (){
            widget.audioPlayer.seekToPrevious();
          }, 
          icon: const Icon(Icons.skip_previous), 
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
          color: const Color(0xFF9063CD),
        ),
        //siguiente
        IconButton(
          onPressed: () {
            widget.audioPlayer.seekToNext();
          }, 
          icon: const Icon(Icons.skip_next), iconSize: 30,
        ),
        //aleatorio
        IconButton(
          onPressed: (){
            if (_flagIsShuffling == false) {
              widget.audioPlayer.setShuffleModeEnabled(true);
              _flagIsShuffling = true;
            } else {
              widget.audioPlayer.setShuffleModeEnabled(false);
              _flagIsShuffling = false;
            }
          }, 
          icon: Icon(_flagIsShuffling ? Icons.shuffle_rounded  : Icons.shuffle),
          iconSize: 30,
        )
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
      nullArtworkWidget: const Icon(Icons.music_note, size: 100.0,),
    );
  }
}