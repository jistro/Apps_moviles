import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key, required this.songModel}) : super(key: key);

  final SongModel songModel;

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _flagIsPlaying = false;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  playSong() {
    if (widget.songModel.data != null) {
      try {
        _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.data.toString())));
        _audioPlayer.play();
        _flagIsPlaying = true;
      } on Exception {
        print("error parsing song");
      }
    } else {
      print("uri is null");
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(03.0),//or 15.0
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        color: Color(0xFF9063CD),
                        child: Icon(Icons.music_note, size: 100.0,),
                      ),
                    ),
                    SizedBox(height: 50.0,),
                    Text(widget.songModel.title.toString() , 
                    overflow: TextOverflow.fade, maxLines: 1, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0,),
                    Text(widget.songModel.artist.toString() == "null" ? "Desconocido": widget.songModel.artist.toString(), 
                    overflow: TextOverflow.fade, maxLines: 1, style: TextStyle(fontSize: 10.0)),
                    const SizedBox(height: 30.0,),
                    Row(
                      children: [
                        Text("00:00"),
                        Expanded(
                          child: Slider(value: 0.0, onChanged: (value) {}, min: 0.0, max: 100.0, activeColor: Color(0xFF9063CD), inactiveColor: Colors.grey,),
                        ),
                        Text("00:00"),
                      ],
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.repeat), iconSize: 30,),
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.skip_previous), iconSize: 30,),
                            IconButton(onPressed: (){
                              setState(() {
                                
                                if(_flagIsPlaying){
                                  _audioPlayer.pause();
                                  _flagIsPlaying = false;
                                }
                                else{
                                  _audioPlayer.play();
                                  _flagIsPlaying = true;
                                }
                                });
                            }, icon: Icon(_flagIsPlaying ? Icons.pause_rounded : Icons.play_arrow), iconSize: 60.0, color: Color(0xFF9063CD),),
                            IconButton(onPressed: (){}, icon: Icon(Icons.skip_next), iconSize: 30,),
                            IconButton(onPressed: (){}, icon: Icon(Icons.shuffle), iconSize: 30,),
                          ],
                        )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}