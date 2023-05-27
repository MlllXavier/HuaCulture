import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hua_culture/entity/video_entity.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/public/utils.dart';
import 'package:video_player/video_player.dart';


//带封面的视频播放器
class VideoPlayerWithCover extends StatefulWidget {
  final VideoEntity video;

  VideoPlayerWithCover({
    Key key,
    @required this.video
  }) : super(key: key);

  @override
  _VideoPlayerWithCoverState createState() => _VideoPlayerWithCoverState();
}

class _VideoPlayerWithCoverState extends State<VideoPlayerWithCover> {
  bool _isPlay = false;

  void _switchToPlayMode() {
    setState(() {
      _isPlay = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: _isPlay
      ? VideoPlayerWithControlBar(video: widget.video,)
      : Container(
      height: 200,
      child: GestureDetector(//否则监测手势
        onTap: Feedback.wrapForTap((_switchToPlayMode), context),
        child: Stack(
            children: <Widget>[
              CachedNetworkImage(imageUrl: globalUrl + widget.video.coverUrl, fit: BoxFit.cover,),//视频封面图
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.play_arrow, size: 36, color: Colors.white),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}

class VideoPlayerWithControlBar extends StatefulWidget {
  final VideoEntity video;

  VideoPlayerWithControlBar({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _VideoPlayerWithControlBarState createState() => _VideoPlayerWithControlBarState();
}

class _VideoPlayerWithControlBarState extends State<VideoPlayerWithControlBar> {
  static VideoPlayerController _activeController;//外部的controller，表示正在活动的controller
  VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isEnded = false;
  bool _isControlBarInvisible = true;
  String tips = "";//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GestureDetector(
        onTap: Feedback.wrapForTap(_toggleControlling, context),//点击隐藏或显示控制栏
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: _isInitialized,
              child: VideoPlayer(_controller),
            ),
            Visibility(
              visible: _isInitialized && _isControlBarInvisible,
              child: _buildControlBar(),
            ),
            Visibility(
              visible: !_isInitialized,
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    if(_activeController != null){
      _activeController.pause();
    }
    _activeController = _controller;
    _controller = VideoPlayerController.network(globalUrl + widget.video.url);
    _controller
      ..initialize()
      ..addListener(_controllerListener);//给controller添加监听器
  }

  @override
  void dispose() {
    if(_activeController == _controller){
      _activeController = null;
    }
    // if(_controlBarInvisibleTimer?.isActive == true) {
    //   _controlBarInvisibleTimer.cancel();
    // }
    _controller
      ..removeListener(() { })
      ..dispose();
    super.dispose();
  }

  //监听器
  void _controllerListener(){
    if (_controller.value.hasError) {
      setState(() {
        tips = '播放错误：' + _controller.value.errorDescription;
      });
      return;
    }
    if (!_controller.value.isInitialized) {
      setState(() {
        tips = '初始化中...';
      });
      return;
    }
    if (_controller.value.isBuffering) {
      setState(() {
        tips = '缓冲中...';
      });
      return;
    }else{
      _isInitialized = true;
      if (!_isPlaying) {
        _play();
        setState(() {
          tips = '';
        });
      }
    }
    if(_controller.value.isPlaying && !_isEnded){
      _isPlaying = true;
      setState(() {
        
      });
    }else {
      _isPlaying = false;
      setState(() {
        
      });
    }
    if (!_isEnded && _controller.value.position >= _controller.value.duration) {
      _isEnded = true;
      _isControlBarInvisible = true;
    } else if (_isEnded && _controller.value.position < _controller.value.duration) {
      _isEnded = false;
      _isControlBarInvisible = true;
    }
  }

  void _play(){
    if(_isEnded){//如果已经播放结束，则跳转到开始
      _controller.seekTo(Duration(seconds: 0));
    } else {
      _controller.play();
    }
    // if(_isControlBarInvisible){//如果控制条可见，则重新开启定时器，一段时间后隐藏
    //   if(_controlBarInvisibleTimer?.isActive == true){///////////////////////////////////////////////////////////////////////////////可更改为timer != null
    //     _controlBarInvisibleTimer.cancel();
    //   }
    //   _controlBarInvisibleTimer = Timer(Duration(seconds: 2), (){
    //     if(_isPlaying){
    //       setState(() {
    //         _isControlBarInvisible = false;
    //       });
    //     }
    //   });
    // }
  }

  void _togglePlaying(){//播放与暂停按钮
    if(_isPlaying){
      _controller.pause();
    }else {
      _play();
    }
    setState(() {
      
    });
  }

  void _toggleControlling(){//控制条可见与否
    setState(() {
      _isControlBarInvisible = !_isControlBarInvisible;
    });
  }

  Widget _buildControlBar(){//控制条组件
    return Stack(
      children: <Widget>[
        Container(//播放按钮
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: Feedback.wrapForTap(_togglePlaying, context),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 45,
                color: Colors.white,
              ),
            ),
          )
        ),
        Container(//进度条
          alignment: Alignment.bottomCenter,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Row(
              children: <Widget>[
                Container(//当前进度
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(TimeUtils.getCurrentPosition(_controller.value.position.inSeconds)),
                ),
                Flexible(//进度条
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  )
                ),
                Container(//总长度
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(TimeUtils.getCurrentPosition(_controller.value.duration.inSeconds)),
                ),
              ],
            ),
          )
        )
      ],
    );
  }
}