import 'package:flutter/material.dart';
import 'package:hua_culture/pages/other_pages/login_page.dart';
import 'package:hua_culture/pages/other_pages/setting_page.dart';
import 'package:hua_culture/pages/other_pages/verify_page.dart';
import 'package:hua_culture/public/Toast.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/widgets/cards_widget.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin {
  List tabs = ["我发布的", "我喜欢的（" + globalUser.likeNum.toString() + "）", "我评论的（" + globalUser.commentNum.toString() + "）"];
  PageController pageController;
  int _currentPage = 0;
  int _tag = 0;

  @override
  void initState() {
    super.initState();
    pageController = new PageController(
      //用来配置PageView中默认显示的页面 从0开始
      initialPage: 0,
      //为true是保持加载的每个页面的状态
      keepPage: true,
    );
    pageController.addListener(() {
      //PageView滑动的距离
      double offset = pageController.offset;
      //当前显示的页面的索引
      double page = pageController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                  color: Colors.red[400],
                  height: _tag == 0 ? 180 : 360,
                )
              ),
              GestureDetector(
                child: _tag == 0 ? Column(
                  children: [
                    ClipOval(child: Image.network(globalUrl + globalUser.avatar, width: 64, height: 64),),
                    Text(globalUser.name),
                    Text(globalUser.intro),
                  ]
                ) : Column(
                  children: [
                    ClipOval(child: Image.network(globalUrl + globalUser.avatar, width: 64, height: 64),),
                    Text("账号：" + globalUser.username.toString()),
                    Text("昵称：" + globalUser.name),
                    Text("简介：" + globalUser.intro),
                    Text("兴趣类型：" + globalUser.classes),
                    Text("喜欢数：" + globalUser.likeNum.toString()),
                    Text("评论数：" + globalUser.commentNum.toString()),
                    Text("是否具有审核资格：" + globalUser.isVerifiable.toString()),
                    Text("注册时间：" + globalUser.time),
                  ],
                ),
                onTap: () {
                  if (globalUser.username == null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  } else {
                    setState(() {
                      if(_tag == 0) {
                        _tag = 1;
                      } else {
                        _tag = 0;
                      }
                    });
                  }
                },
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                ),
                right: 6.0,
                top: 18.0,
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(Icons.verified_outlined),
                  onPressed: (){
                    if (globalUser.isVerifiable) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPage()));
                    } else {
                      Toast.toast(context, msg: "您还没有审核资格哦");
                    }
                  },
                ),
                left: 6.0,
                top: 18.0,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Center(child: Text(tabs[0]),),
                  width: screenSize.widght/3.0 - 4,
                  height: 40,
                  color: _currentPage == 0 ? Colors.red[400] : Colors.red[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
                ),
                onTap: () {
                  pageController.animateToPage(0, duration: Duration(milliseconds: 16), curve: Curves.fastOutSlowIn);
                },
              ),
              GestureDetector(
                child: Container(
                  child: Center(child: Text(tabs[1]),),
                  width: screenSize.widght/3.0 - 4,
                  height: 40,
                  color: _currentPage == 1 ? Colors.red[400] : Colors.red[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
                ),
                onTap: () {
                  pageController.animateToPage(1, duration: Duration(milliseconds: 16), curve: Curves.fastOutSlowIn);
                },
              ),
              GestureDetector(
                child: Container(
                  child: Center(child: Text(tabs[2]),),
                  width: screenSize.widght/3.0 - 4,
                  height: 40,
                  color: _currentPage == 2 ? Colors.red[400] : Colors.red[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
                ),
                onTap: () {
                  pageController.animateToPage(2, duration: Duration(milliseconds: 16), curve: Curves.fastOutSlowIn);
                },
              ),
            ]
          ),
          Expanded(
            child: Container(
              height: 300,
              child: 
              PageView(
                controller: pageController,
                physics:BouncingScrollPhysics(),
                onPageChanged: (index) {
                  //监听事件
                  print('index=====$index');
                  _currentPage = index;
                  setState(() {});
                },
                children: <Widget>[
                  Container(
                    child: userCards()
                  ),
                  Container(
                    child: userCards()
                  ),
                  Container(
                    child: userCards()
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget userCards(){
    if (globalUser.username != null) {
      if (_currentPage == 0) {
        return CardsWidget(category: 0, categoryIndex: 0, userTag: _currentPage);
      } else if (_currentPage == 1) {
        if (globalUser.likeNum != 0) {
          return CardsWidget(category: 0, categoryIndex: 0, userTag: _currentPage);
        } else {
          return Text("您一张喜欢的卡片也没有哦");
        }
      } else if (_currentPage == 2) {
        if (globalUser.commentNum != 0){
          return CardsWidget(category: 0, categoryIndex: 0, userTag: _currentPage);
        } else {
          return Text("您一条评论也没有发布过哦");
        }
      }
    } else {
      return Text("登录后才有此内容哦");
    } 
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;

    // var path = Path();
    // path.lineTo(0, size.height - 20);
    // var firstControlPoint = Offset(size.width / 4, size.height);
    // var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstEndPoint.dx, firstEndPoint.dy);
    // var secondControlPoint = Offset(size.width / 4 * 3, size.height - 80);
    // var secondEndPoint = Offset(size.width, size.height - 40);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);
    // path.lineTo(size.width, size.height - 40);
    // path.lineTo(size.width, 0);
    // return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}