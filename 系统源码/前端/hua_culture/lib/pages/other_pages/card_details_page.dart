import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hua_culture/entity/card_entity.dart';
import 'package:hua_culture/entity/comment_entity.dart';
import 'package:hua_culture/entity/user_entity.dart';
import 'package:hua_culture/pages/other_pages/login_page.dart';
import 'package:hua_culture/public/Toast.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/widgets/card_content.dart';

class CardDetailsPage extends StatefulWidget {
  final CardEntity card;
  CardDetailsPage({Key key, @required this.card,}) : super(key: key);

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  CardEntity _card;
  UserEntity _user;
  List<CommentEntity> _comments = new List();
  ScrollController  _controller = new ScrollController();
  TextEditingController commentController = TextEditingController();//评论的控制器
  FocusNode commentFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _card = widget.card;
    _retrieveComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卡片详情"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(child: Image.network(globalUrl + _card.user.avatar, width: 48, height: 48)),
                        Container(width: 16,),
                        Text(_card.user.name),
                      ]
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(_card.intro),
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        )
                      ],
                    ),
                    CardContent(card: _card),
                  ],
                ),
              ), 
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          iconSize: 24,
                          icon: _card.isLike?Icon(Icons.favorite_sharp, color: Colors.red[500]):Icon(Icons.favorite_border),
                          onPressed: () async {
                            if(globalUser.username == null){//若没有登录则弹出登录页面
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            } else {
                              String url = globalUrl + "card/likeCard";
                              FormData formdata = FormData.fromMap({
                                "user_id": globalUser.username,
                                "card_id": _card.cardID
                              });
                              Dio dio = new Dio();
                              var respone = await dio.post<String>(url, data: formdata);
                              if (respone.statusCode == 200) {
                                _card.isLike = true;
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
                  Container(
                    child: Row(
                      children: [
                        Expanded(//不加expanded会报错，这是TextField的一个需要注意的点 https://segmentfault.com/q/1010000017980926
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              labelText: '在此输入评论',
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.send,
                            focusNode: commentFocusNode,
                            maxLength: 32,
                            onEditingComplete: _common,
                          ),
                        ),
                        RaisedButton(
                          onPressed: _common,
                          child: Text('发表评论'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 500,
                    child: ListView.separated(
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //如果到了表尾
                        if (index == _comments.length - 1) {
                          //不足30条，继续获取数据
                          if (_comments.length - 1 < 30) {
                            //获取数据
                            _retrieveComments();
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
                        return ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(child: Image.network(globalUrl + _comments[index].user.avatar, width: 36, height: 36)),
                                  Container(width: 16,),
                                  Text(_comments[index].user.name),
                                ]
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(_comments[index].content),
                                    margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  )
                                ],
                              ),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              //点赞
                            ],
                          ),
                        );
                      }, 
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.red);
                      },
                      itemCount: _comments.length,
                      controller: _controller,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _common() async {
    commentFocusNode.unfocus();
    if (globalUser.username == null){
      Toast.toast(context, msg: "登录后才可以评论哦");
      return;
    }
    if(commentController.text != ""){
      var url = globalUrl + 'card/commentCard';
      FormData formdata = FormData.fromMap({
        "user_id": globalUser.username,
        "card_id": _card.cardID,
        "content": commentController.text
      });
      Dio dio = new Dio();
      var respone = await dio.post<String>(url, data: formdata);
      if (respone.statusCode == 200) {
      if(respone.data == "true"){
        setState(() {
        });
      }
    }
    } else {
      Toast.toast(context, msg: "请输入评论");
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
        Toast.toast(context, msg: "评论用户错误");
      }
    }
    else{
      
    }
  }

  _getComments() async {
    List<CommentEntity> comments = new List();
    String path = globalUrl + 'card/getCommentsById?id=' + _card.cardID.toString();
    Dio dio = new Dio();
    Response response = await dio.get(path);
    if(response.statusCode == 200){
      if(response.data != ""){
        List data = response.data;
        for(int i = 0; i < data.length; i++){
          CommentEntity comment = new CommentEntity();
          comment.cardID = _card.cardID;
          comment.commentID = data[i]["comment_id"];
          comment.content = data[i]["content"];
          await _getUser(data[i]["user_id"]);
          if(_user != null){
            comment.user = _user;
            _user = null;
          }
          comments.add(comment);
        }
        _comments.addAll(comments);
      } else {
        Toast.toast(context, msg: "暂无评论");
      }
    } else {
      Toast.toast(context, msg: "网络错误");
    }
  }

  _retrieveComments() async {
    await _getComments();
    setState(() {
      
    });
  }
}