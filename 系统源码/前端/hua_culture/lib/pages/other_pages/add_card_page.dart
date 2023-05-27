import 'package:flutter/material.dart';
import 'package:hua_culture/public/Toast.dart';
import 'package:hua_culture/public/config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class AddCardPage extends StatefulWidget {
  AddCardPage({Key key}) : super(key: key);

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController introController = new TextEditingController();
  TextEditingController sourceController = new TextEditingController();
  TextEditingController classesController = new TextEditingController();
  int _value = 0;
  final _picker = ImagePicker();
  File _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加卡片'),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: introController,
                decoration: InputDecoration(
                    labelText: "简介（非必填）",
                    hintText: "卡片的简单介绍",
                    prefixIcon: Icon(Icons.short_text_sharp)
                ),
              ),
              DropdownButton(
                hint: Text("选择卡片类型"),
                items: [
                  DropdownMenuItem(child: Text("视频"), value: 0,),
                  DropdownMenuItem(child: Text("音频"), value: 1,),
                  DropdownMenuItem(child: Text("图片"), value: 2,),
                  DropdownMenuItem(child: Text("文章"), value: 3,),
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              _value == 0 ? Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _takeVideo,
                      child: Text("拍摄视频"),
                    ),
                    RaisedButton(
                      onPressed: _getVideo,
                      child: Text("选择本地视频"),
                    ),
                    _file == null
                      ? Text('No selected.')
                      : Text(_file.path)
                  ],
                ),
              )
              : _value == 1 ? Text("音频")
              : _value == 2 ? Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _takePhoto,
                      child: Text("拍照"),
                    ),
                    RaisedButton(
                      onPressed: _openGallery,
                      child: Text("选择照片"),
                    ),
                    _file == null
                      ? Text('No selected.')
                      : Container(
                        child: Image.file(_file, fit: BoxFit.cover,),
                        width: 240,
                        height: 240,
                      ),
                  ],
                ),
              )
              : _value == 3 ? Text("文章")
              : Text("类型错误"),
              TextField(
                controller: classesController,
                decoration: InputDecoration(
                    labelText: "卡片类别（如：历史、汉服）",
                    hintText: "请输入卡片类别",
                    prefixIcon: Icon(Icons.category_outlined)
                ),
              ),
              TextField(
                controller: sourceController,
                decoration: InputDecoration(
                    labelText: "来源（必填）",
                    hintText: "请输入卡片内容的来源",
                    prefixIcon: Icon(Icons.source_outlined)
                ),
              ),
              FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("上传"),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: _upLoadFile,
              )
            ]
          )
        )
    );
  }

  /*拍照*/
  _takePhoto() async {
    PickedFile  pickedFile = await _picker.getImage(source: ImageSource.camera);
    print('拍照返回：' + pickedFile.toString());
    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No selected.');
      }
    });
  }
  
  /*相册*/
  _openGallery() async {
    PickedFile  pickedFile = await _picker.getImage(source: ImageSource.gallery);
    print('相册返回：' + pickedFile.toString());
    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No selected.');
      }
    });
  }

  /*选取视频*/
  _getVideo() async {
    PickedFile  pickedFile = await _picker.getVideo(source: ImageSource.gallery);
    print('选取视频：' + pickedFile.toString());
    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No selected.');
      }
    });
  }
  /*拍摄视频*/
  _takeVideo() async {
    PickedFile  pickedFile = await _picker.getVideo(source: ImageSource.camera);
    print('拍摄视频：' + pickedFile.toString());
    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No selected.');
      }
    });
  }

  //上传文件
  _upLoadFile() async {
    if (globalUser == null){
      Toast.toast(context,msg: "请登录");
      return;
    } else if (_file == null){
      Toast.toast(context,msg: "请添加文件");
      return;
    } else if (classesController.text == "") {
      Toast.toast(context,msg: "请输入卡片类别");
      return;
    } else if (sourceController.text == ""){
      Toast.toast(context,msg: "请输入卡片来源");
      return;
    }

    String path = _file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    String url = globalUrl + "card/upload";
 
    FormData formdata = FormData.fromMap({
      "multipartFile": await MultipartFile.fromFile(path, filename:name),
      "user_id": globalUser.username,
      "intro": introController.text,
      "types": _value,
      "classes": classesController.text,
      "source": sourceController.text
    });

    Dio dio = new Dio();
    var respone = await dio.post<String>(url, data: formdata);
    if (respone.statusCode == 200) {
      Toast.toast(context,msg: "上传成功");
      Navigator.pop(context);
    }
    else{
      Toast.toast(context,msg: "上传失败");
    }
  }
}