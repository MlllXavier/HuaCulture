import 'package:flutter/material.dart';
import 'package:hua_culture/entity/video_entity.dart';
import 'package:hua_culture/widgets/my_video_player.dart';

class DaoReligion extends StatelessWidget {
  const DaoReligion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoEntity video = new VideoEntity();
    video.coverUrl = "static/8~@Z~3]K5TDP[S]LHH]D`UX.jpg";
    video.url = "static/1304103917.mp4";

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