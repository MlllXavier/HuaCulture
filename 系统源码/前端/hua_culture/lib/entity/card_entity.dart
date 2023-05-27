import 'package:hua_culture/entity/user_entity.dart';

import 'video_entity.dart';
import 'audio_entity.dart';
import 'photo_entity.dart';
import 'article_entity.dart';

class CardEntity{
  int cardID;
  UserEntity user;
  String intro = "";
  int types;//0：视频   1：音频   2：图片   3：文章
  String classes;
  VideoEntity video;
  AudioEntity audio;
  List<PhotoEntity> photos;
  ArticleEntity article;
  String source;
  int likeNum;
  int commentNum;
  bool isLike = false;
  bool isChecked;
  int checker;
  String time;
}