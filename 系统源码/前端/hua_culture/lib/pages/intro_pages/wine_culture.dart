import 'package:flutter/material.dart';
import 'package:hua_culture/entity/video_entity.dart';
import 'package:hua_culture/widgets/my_video_player.dart';

class WineCulture extends StatelessWidget {
  const WineCulture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoEntity video = new VideoEntity();
    video.coverUrl = "static/%L6H7SXZB34KKC@ONS9_{04.jpg";
    video.url = "static/1262411243.mp4";

    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      child: Column(
        children: [
          VideoPlayerWithCover(video: video),
        ],
      )
    );
  }
}