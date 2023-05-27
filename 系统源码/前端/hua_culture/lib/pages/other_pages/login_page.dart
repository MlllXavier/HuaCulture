import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hua_culture/public/Toast.dart';
import 'package:hua_culture/public/config.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// 可将Text Field修改为Form 见：https://book.flutterchina.club/chapter3/input_and_form.html#_3-7-2-%E8%A1%A8%E5%8D%95form
class _LoginPageState extends State<LoginPage> {
  String _username = '';//用户名
  String _password = '';//密码
  TextEditingController usernameController = TextEditingController();//账号的控制器
  TextEditingController passwordController = TextEditingController();//密码的控制器
  FocusNode idFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        idFocusNode.unfocus();
        passwordFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('请登录')),
        body: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: '请输入您的账号',
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.account_box),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofocus: false,//自动聚焦
              focusNode: idFocusNode,
              maxLength: 16,
              onEditingComplete: _skipToNext,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: '请输入密码',
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              obscureText: true,//密码遮掩
              focusNode: passwordFocusNode,
              maxLength: 16,
              onEditingComplete: _login,
            ),
            RaisedButton(
              onPressed: _login,
              child: Text('登录'),
            ),
            RaisedButton(
              onPressed: _register,
              child: Text('注册'),
            ),
          ],
        ),
      )
    );
  }

  _skipToNext() {
    if(null == focusScopeNode) {
      focusScopeNode = FocusScope.of(context);
    }
    focusScopeNode.requestFocus(passwordFocusNode);
  }

  _login() async {
    _username = usernameController.text;
    _password = passwordController.text;
    print({'phone': usernameController.text, 'password': passwordController.text});
    if (usernameController.text.length == 0) {
      Toast.toast(context,msg: "请输入用户名");
    }
    else if (passwordController.text.length == 0) {
      Toast.toast(context,msg: "请输入密码");
    }
    else {
      await _getPassword();
    }
  }

  _getPassword() async {
    var url = globalUrl + 'user/getById?id=' + _username;
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.statusCode == 200){
      if(response.data == ""){
        Toast.toast(context, msg: "用户名错误");
        usernameController.text = "";
        passwordController.text = "";
      } else {
        var data = response.data;
        if(data['password'] == _password){
          globalUser.username = int.parse(_username);
          globalUser.name = data['name'];
          globalUser.avatar = data['photo'];
          globalUser.intro = data['intro'];
          globalUser.classes = data['classes'];
          globalUser.likeNum = data['like_num'];
          globalUser.commentNum = data['comment_num'];
          globalUser.isVerifiable = data['_verifiable'];
          globalUser.time =  data['time'];
          Toast.toast(context, msg: "登录成功");
          Navigator.pop(context);
        } else {
          Toast.toast(context, msg: "密码错误");
          passwordController.text = "";
        }
      }
    } else {
      Toast.toast(context, msg: "网络错误");
    }
  }

  Future<int> _addUser() async {
    String url = globalUrl + 'user/getById?id=' + _username;
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      if(response.data != ""){
        return 1;
      } else {
        url = globalUrl + "user/addUser";
        FormData formdata = FormData.fromMap({
          "username": _username,
          "password": _password,
        });
        dio = new Dio();
        var respone = await dio.post<String>(url, data: formdata);
        if (respone.statusCode == 200) {
          return 0;
        }
        else{
          return -1;
        }
      }
    }
    else{
      return -1;
    }
  }

  _register() async {
    _username = usernameController.text;
    _password = passwordController.text;
    print({'username': usernameController.text, 'password': passwordController.text});
    if (usernameController.text.length == 0) {
      Toast.toast(context,msg: "请输入用户名");
    }
    else if (passwordController.text.length == 0) {
      Toast.toast(context,msg: "请输入密码");
    }
    else {
      int result = await _addUser();
      if (result == 0) {
        Toast.toast(context, msg: "注册成功，请点击登录");
      } else if (result == 1) {
        passwordController.clear();
        Toast.toast(context, msg: "该用户名已注册");
      } else {
        Toast.toast(context,msg: "网络错误");
      }
    }
  }
}