import 'package:flutter/material.dart';
import 'package:hua_culture/entity/card_entity.dart';

import 'my_article_viewer.dart';
import 'my_audio_players.dart';
import 'my_photo_view.dart';
import 'my_video_player.dart';

class CardContent extends StatefulWidget {
  final CardEntity card;
  
  CardContent({
    Key key,
    @required this.card,
  }) : super(key: key);

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  CardEntity _card;

  @override
  void initState() {
    super.initState();
    _card = widget.card;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_card.types == 0){
      return VideoPlayerWithCover(video: _card.video);
    }
    else if(_card.types == 1){
      return AudioPlayersWithStyle(audio: _card.audio);
    }
    else if(_card.types == 2){
      return PhotoViewerWithGrid(photos: _card.photos);
    }
    else if(_card.types == 3){
      return ArticleViewerWithLimit(article: _card.article);
    }
    else{
      return Text("类型错误");
    }
  }
}