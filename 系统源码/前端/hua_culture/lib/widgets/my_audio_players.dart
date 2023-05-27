import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hua_culture/entity/audio_entity.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/public/utils.dart';

class AudioPlayersWithStyle extends StatefulWidget {
  final AudioEntity audio;
  AudioPlayersWithStyle({Key key, @required this.audio}) : super(key: key);

  @override
  _AudioPlayersWithStyleState createState() => _AudioPlayersWithStyleState();
}

class _AudioPlayersWithStyleState extends State<AudioPlayersWithStyle> {
  AudioEntity _audio;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration();
  Duration _currentDuration = Duration();
  Widget _playIcon = Icon(Icons.play_arrow, size: 36,);
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audio = widget.audio;
    AudioPlayer.logEnabled = true;////////////////////////////////调试打印日志
    
    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == AudioPlayerState.COMPLETED) {
      } else if (playerState == AudioPlayerState.PAUSED) {
        setState(() {
          _isPlaying = false;
        });
      } else if (playerState == AudioPlayerState.PLAYING) {
        setState(() {
          _isPlaying = true;
        });
      } else if (playerState == AudioPlayerState.STOPPED) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        _currentDuration = event;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        color: Colors.pink,
        child: Row(
          children: <Widget>[
            IconButton(
              iconSize: 48,
              alignment: Alignment.center,
              icon: _playIcon,
              onPressed: _playOrPause,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              TimeUtils.getCurrentPosition(_currentDuration.inSeconds),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // 进度条
            Expanded(
              child: LinearProgressIndicator(
                value: TimeUtils.getProgress(_currentDuration.inSeconds, _duration.inSeconds),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                backgroundColor: Colors.white,
              )
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              TimeUtils.getCurrentPosition(_duration.inSeconds),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              iconSize: 48,
              alignment: Alignment.center,
              icon: Icon(Icons.stop, size: 36,),
              onPressed: _stop,
            ),
          ],
        ),
      )
    );
  }

  _playOrPause() async {
    if (_isPlaying) {
      await audioPlayer.pause();
      setState(() {
        _playIcon = Icon(Icons.play_arrow, size: 36,);
      });
    } else {
      await audioPlayer.play(globalUrl + _audio.url);
      setState(() {
        _playIcon = Icon(Icons.pause, size: 36,);
      });
    }
  }

  _stop() async {
    await audioPlayer.stop();
    setState(() {
        _playIcon = Icon(Icons.play_arrow, size: 36,);
        _currentDuration = new Duration();
    });
  }
}