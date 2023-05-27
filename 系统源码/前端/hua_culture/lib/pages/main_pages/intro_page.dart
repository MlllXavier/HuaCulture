import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hua_culture/pages/intro_pages/chinese_culture.dart';
import 'package:hua_culture/pages/intro_pages/dao_religion.dart';
import 'package:hua_culture/pages/intro_pages/page1.dart';
import 'package:hua_culture/pages/intro_pages/page2.dart';
import 'package:hua_culture/pages/intro_pages/wine_culture.dart';
import 'package:hua_culture/public/config.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _category = 0;
  int _categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categories[_category][_categoryIndex]),
      ),
      drawer: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 24,
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("中华文化"),),
                    color: Colors.blue[400],
                  ),
                  onTap: () {
                    setState(() {
                      _category = 0;
                      _categoryIndex = 0;
                    });
                    Navigator.pop(context);
                  },
                ),
                ExpansionTile(
                  title: Text(categories[1][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[1][1]),
                      onTap: () {
                        setState(() {
                          _category = 1;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[1][2]),
                      onTap: () {
                        setState(() {
                          _category = 1;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[1][3]),
                      onTap: () {
                        setState(() {
                          _category = 1;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[2][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[2][1]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][2]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][3]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][4]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][5]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][6]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][7]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 7;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][8]),
                      onTap: () {
                        setState(() {
                          _category = 2;
                          _categoryIndex = 8;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[3][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[3][1]),
                      onTap: () {
                        setState(() {
                          _category = 3;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][2]),
                      onTap: () {
                        setState(() {
                          _category = 3;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][3]),
                      onTap: () {
                        setState(() {
                          _category = 3;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][4]),
                      onTap: () {
                        setState(() {
                          _category = 3;
                          _categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][5]),
                      onTap: () {
                        setState(() {
                          _category = 3;
                          _categoryIndex = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][6]),
                      onTap: () {
                        setState(() {
                          _category = 3;
                          _categoryIndex = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[4][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[4][1]),
                      onTap: () {
                        setState(() {
                          _category = 4;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[4][2]),
                      onTap: () {
                        setState(() {
                          _category = 4;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[4][3]),
                      onTap: () {
                        setState(() {
                          _category = 4;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[5][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[5][1]),
                      onTap: () {
                        setState(() {
                          _category = 5;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[5][2]),
                      onTap: () {
                        setState(() {
                          _category = 5;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[5][3]),
                      onTap: () {
                        setState(() {
                          _category = 5;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[5][4]),
                      onTap: () {
                        setState(() {
                          _category = 5;
                          _categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[6][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[6][1]),
                      onTap: () {
                        setState(() {
                          _category = 6;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[6][2]),
                      onTap: () {
                        setState(() {
                          _category = 6;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[6][3]),
                      onTap: () {
                        setState(() {
                          _category = 6;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[6][4]),
                      onTap: () {
                        setState(() {
                          _category = 6;
                          _categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[7][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[7][1]),
                      onTap: () {
                        setState(() {
                          _category = 7;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[7][2]),
                      onTap: () {
                        setState(() {
                          _category = 7;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[7][3]),
                      onTap: () {
                        setState(() {
                          _category = 7;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[8][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[8][1]),
                      onTap: () {
                        setState(() {
                          _category = 8;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[8][2]),
                      onTap: () {
                        setState(() {
                          _category = 8;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[8][3]),
                      onTap: () {
                        setState(() {
                          _category = 8;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[9][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[9][1]),
                      onTap: () {
                        setState(() {
                          _category = 9;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][2]),
                      onTap: () {
                        setState(() {
                          _category = 9;
                          _categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][3]),
                      onTap: () {
                        setState(() {
                          _category = 9;
                          _categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][4]),
                      onTap: () {
                        setState(() {
                          _category = 9;
                          _categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][5]),
                      onTap: () {
                        setState(() {
                          _category = 9;
                          _categoryIndex = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][6]),
                      onTap: () {
                        setState(() {
                          _category = 9;
                          _categoryIndex = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(categories[10][0]),
                  leading: Icon(Icons.adjust_rounded),
                  backgroundColor: Colors.white12,
                  children: <Widget>[
                    ListTile(
                      title: Text(categories[10][1]),
                      onTap: () {
                        setState(() {
                          _category = 10;
                          _categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _content(_category, _categoryIndex)
      ),
    );
  }

  Widget _content(int category, int categoryIndex){
    if(category == 0){
      if(categoryIndex == 0){
        return ChineseCulture();
      }
    }
    if(category == 1){
      if(categoryIndex == 0){
        return Page1();
      }
      if(categoryIndex == 1){
        return Page2();
      }
    }
    if(category == 3){
      if(categoryIndex == 1){
        return DaoReligion();
      }
    }

    if(category == 7){
      if(categoryIndex == 2){
        return WineCulture();
      }
    }
    return Container();
  }
}
