import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hua_culture/entity/article_entity.dart';
import 'package:hua_culture/entity/audio_entity.dart';
import 'package:hua_culture/entity/card_entity.dart';
import 'package:hua_culture/entity/photo_entity.dart';
import 'package:hua_culture/entity/user_entity.dart';
import 'package:hua_culture/entity/video_entity.dart';
import 'package:hua_culture/pages/other_pages/card_details_page.dart';
import 'package:hua_culture/pages/other_pages/login_page.dart';
import 'package:hua_culture/public/Toast.dart';
import 'package:hua_culture/public/config.dart';
import 'card_content.dart';

class CardsWidget extends StatefulWidget {
  final int category;
  final int categoryIndex;
  final String query;
  final int userTag;
  final bool isVerify;
  final int types;
  CardsWidget({Key key, @required this.category, @required this.categoryIndex, this.query, this.userTag, this.isVerify, this.types}) : super(key: key);

  @override
  _CardsWidgetState createState() => _CardsWidgetState();
}

class _CardsWidgetState extends State<CardsWidget> {
  List<CardEntity> _cards = new List();
  UserEntity _user;
  VideoEntity _video;
  AudioEntity _audio;
  List<PhotoEntity> _photos;
  ArticleEntity _article;
  ScrollController  _controller = new ScrollController();
  bool _isLike = false;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _cards.length,
      controller: _controller,
      separatorBuilder: (context, index) {
        return Divider(color: Colors.red);
      },
      itemBuilder: (context, index) {
        //如果到了表尾
        if (index == _cards.length - 1) {
          //不足20条，继续获取数据
          if (_cards.length - 1 < 20) {/////////////////////////////////////////////
            //获取数据
            _retrieveData();
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                child: Text("我是有底线的", style: TextStyle(color: Colors.grey))
            );
          }
        }
        //列表项
        return ListTile(
          title: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        ClipOval(child: Image.network(globalUrl + _cards[index].user.avatar, width: 48, height: 48)),
                        Container(width: 16,),
                        Text(_cards[index].user.name),
                      ]
                    ),
                    widget.isVerify != null ? Positioned(
                      child: IconButton(icon: Icon(Icons.check_circle_outlined), onPressed: () async {
                        String url = globalUrl + "card/passCard?id=" + _cards[index].cardID.toString();
                        Dio dio = new Dio();
                        Response response = await dio.post(url);
                        if(response.statusCode == 200){
                          Toast.toast(context, msg: "审核成功");
                        }else{
                          Toast.toast(context, msg: "网络错误");
                        }
                      },),
                      top: 0,
                      right: 0,
                    ) : Container(),
                    widget.isVerify != null ? Positioned(
                      child: IconButton(icon: Icon(Icons.cancel_outlined), onPressed: () async {
                        String url = globalUrl + "card/notPassCard?id=" + _cards[index].cardID.toString();
                        Dio dio = new Dio();
                        Response response = await dio.post(url);
                        if(response.statusCode == 200){
                          Toast.toast(context, msg: "审核成功");
                        }else{
                          Toast.toast(context, msg: "网络错误");
                        }
                      },),
                      top: 0,
                      right: 24,
                    ) : Container(),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Text(_cards[index].intro),
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    )
                  ],
                ),
                CardContent(card: _cards[index]),
              ],
            ),
          ), 
          subtitle: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      iconSize: 24,
                      icon: _cards[index].isLike?Icon(Icons.favorite_sharp, color: Colors.red[500]):Icon(Icons.favorite_border),
                      onPressed: () async {
                        if(globalUser.username == null){//若没有登录则弹出登录页面
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        } else {
                          String url = globalUrl + "card/likeCard";
                          FormData formdata = FormData.fromMap({
                            "user_id": globalUser.username,
                            "card_id": _cards[index].cardID
                          });
                          Dio dio = new Dio();
                          var respone = await dio.post<String>(url, data: formdata);
                          if (respone.statusCode == 200) {
                            _cards[index].isLike = true;
                            globalUser.likeNum++;
                            setState(() {});
                          }
                          else{
                          }
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      iconSize: 24,
                      icon: Icon(Icons.chat_outlined),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailsPage(card: _cards[index])));
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      iconSize: 24,
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {
                      },
                    ),
                  ),
                ]
              ),
            ],
          )
        );
      },
    );
  }

  _getVideo(int videoID) async {
    var url = globalUrl + 'card/getVideoById?id=' + videoID.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.statusCode == 200) {
      if(response.data != ""){
        VideoEntity video = new VideoEntity();
        var data = response.data;
        video.videoID = data['video_id'];
        video.groupID = data['group_id'];
        video.username = data['username'];
        video.url = data['url'];
        video.coverUrl = data['cover_url'];
        _video = video;
      } else {
        Toast.toast(context, msg: "卡片视频编号错误");
      }
    }
  }

  _getAudio(int audioID) async {
    var url = globalUrl + 'card/getAudioById?id=' + audioID.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.statusCode == 200) {
      if(response.data != ""){
        var data = response.data;
        AudioEntity audio = new AudioEntity();
        audio.audioID = data['audio_id'];
        audio.groupID = data['group_id'];
        audio.username = data['username'];
        audio.url = data['url'];
        _audio = audio;
      } else {
        Toast.toast(context, msg: "卡片音频编号错误");
      }
    }

  }

  _getPhotos(int photoID) async {
    var url = globalUrl + 'card/getPhotosById?id=' + photoID.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.statusCode == 200) {
      if(response.data != ""){
        List data = response.data;
        List<PhotoEntity> photos = new List();
        for(int i = 0; i < data.length; i++){
          PhotoEntity photo = new PhotoEntity();
          photo.photoID = data[i]['photo_id'];
          photo.groupID = data[i]['group_id'];
          photo.username = data[i]['username'];
          photo.url = data[i]['url'];
          photos.add(photo);
        }
        _photos = photos;
      } else {
        Toast.toast(context, msg: "卡片图片编号错误");
      }
    }
    
  }

  _getArticle(int articleID) async {
    var url = globalUrl + 'card/getArticleById?id=' + articleID.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.statusCode == 200) {
      if(response.data != ""){
        var data = response.data;
        ArticleEntity article = new ArticleEntity();
        article.articleID = data['article_id'];
        article.groupID = data['group_id'];
        article.username = data['username'];
        article.content = data['content'];
        _article = article;
      } else {
        Toast.toast(context, msg: "卡片文章编号错误");
      }
    }
    
  }

  _getUser(int userID) async {
    UserEntity user = new UserEntity();
    var url = globalUrl + 'user/getById?id=' + userID.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      if(response.data != ""){
        var data = response.data;
        user.name = data['name'];
        user.avatar = data['photo'];
        // user.intro = data['intro'];
        // user.classes = data['classes'];
        // user.likeNum = data['like_num'];
        // user.commentNum = data['comment_num'];
        // user.isVerifiable = data['_verifiable'];
        // user.time =  data['time'];
        _user = user;
      } else {
        Toast.toast(context, msg: "卡片用户错误");
      }
    }
    else{
      
    }
  }

  _getCards() async {
    List<CardEntity> cards = new List();
    var url;
    if (widget.query == null){
        if (widget.category == 0 && widget.categoryIndex == 0){
        url = globalUrl + 'card/getCards';
      } else {
        url = globalUrl + 'card/getCardsByCategory?id=' + widget.category.toString() + "_" + widget.categoryIndex.toString();
      }
    } else {
      url = globalUrl + 'card/searchCards?query=' + widget.query;
    }
    if (widget.userTag != null && globalUser.username != null){
      if(widget.userTag == 0){
        url = globalUrl + 'card/getUserCards?id=' + globalUser.username.toString();
      } else if (widget.userTag == 1){
        url = globalUrl + 'card/getUserLikedCards?id=' + globalUser.username.toString();
      } else if (widget.userTag == 2){
        url = globalUrl + 'card/getUserCommentedCards?id=' + globalUser.username.toString();
      }
    }
    if (widget.types != null){
      if(widget.types == 1){
        url = globalUrl + 'card/getVideoCards';
      } else if(widget.types == 2){
        url = globalUrl + 'card/getAudioCards';
      } else if(widget.types == 3){
        url = globalUrl + 'card/getPhotoCards';
      } else if(widget.types == 4){
        url = globalUrl + 'card/getArticleCards';
      }
    }
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      if(response.data != ""){
        List data = response.data;
        for(int i = 0; i < data.length; i++){
          CardEntity card = new CardEntity();
          card.cardID = data[i]["card_id"];
          await _getUser(data[i]["user_id"]);
          if(_user != null){
            card.user = _user;
            _user = null;
          }
          card.intro = data[i]["intro"];
          card.classes = data[i]["classes"];
          card.types = data[i]["types"];
          if(card.types == 0){
            await _getVideo(data[i]["video_id"]);
            if(_video != null){
              card.video = _video;
              _video = null;
            }
          } else if(card.types == 1){
            await _getAudio(data[i]["audio_id"]);
            if(_audio != null){
              card.audio = _audio;
              _audio = null;
            }
          } else if(card.types == 2){
            await _getPhotos(data[i]["photo_id"]);
            if(_photos != null){
              card.photos = _photos;
              _photos = null;
            }
          } else if(card.types == 3){
            await _getArticle(data[i]["article_id"]);
            if(_article != null){
              card.article = _article;
              _article = null;
            }
          }
          card.source = data[i]["source"];
          card.likeNum = data[i]["like_num"];
          card.commentNum = data[i]["comment_num"];
          if(globalUser.username != null){
            await _getIsLike(card.cardID);
            if(_isLike){
              card.isLike = true;
              _isLike = false;
            }
          }
          card.isChecked = data[i]["_checked"];
          card.time = data[i]["time"];
          if (widget.isVerify == null){
            if (card.isChecked){
              cards.add(card);
            }
          } else {
            if (!card.isChecked) {
              cards.add(card);
            }
          }
        }
        _cards.addAll(cards);
      } else {
        Toast.toast(context, msg: "暂无数据");
      }
    }
    else{
      Toast.toast(context, msg: "网络错误");
    }
  }

  _getIsLike(int cardID) async {
    String url = globalUrl + "card/getIsLike";
    FormData formdata = FormData.fromMap({
      "user_id": globalUser.username,
      "card_id": cardID
    });
    Dio dio = new Dio();
    var respone = await dio.post<String>(url, data: formdata);
    if (respone.statusCode == 200) {
      if(respone.data == "true"){
        _isLike = true;
      }
    }
    else{
    }
  }

  _retrieveData() async {
    await _getCards();
    if(mounted)
    setState(() {});
  }
}