import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hua_culture/entity/user_entity.dart';
import 'package:hua_culture/public/Toast.dart';
import 'package:hua_culture/public/config.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(child: Text("修改个人信息"), onPressed: () {}),
            RaisedButton(child: Text("修改密码"), onPressed: () {}),
            RaisedButton(child: Text("网络测试"), onPressed: () async {
              String url = globalUrl + "card/test";
              Dio dio = new Dio();
              try {
                Response response = await dio.post(url);
                if (response.data == "OK"){
                  Toast.toast(context, msg: "网络正常");
                } else {
                  Toast.toast(context, msg: "网络错误");
                }
              } catch (e) {
                Toast.toast(context, msg: "网络错误:" + e.toString());
              }
            }),
            ExpansionTile(
              title: Text("修改主题色"),
              children: [
                ListTile(title: Text("蓝色"), onTap: () {},),
                ListTile(title: Text("红色"), onTap: () {},),
                ListTile(title: Text("绿色"), onTap: () {},),
                ListTile(title: Text("粉色"), onTap: () {},),
              ],
            ),
            RaisedButton(child: Text("退出登录"), color: Colors.red[400], onPressed: () {
              globalUser = new UserEntity();
            }),
          ],
        ),
      ),
    );
  }
}