import 'package:flutter/material.dart';
import 'package:hua_culture/pages/other_pages/add_card_page.dart';
import 'package:hua_culture/pages/other_pages/search_page.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/widgets/cards_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = types;
  

  @override
  void initState() {
    super.initState();
    // 创建Controller  
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('首页'),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
              onPressed: () {
                // 打开抽屉菜单  
                Scaffold.of(context).openDrawer(); 
              },
            );
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegete());
              }
            )
          ],
          bottom: TabBar(   //生成Tab菜单
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()
          ),
        ),
        preferredSize: Size.fromHeight(screenSize.height * 0.13)
      ),
      drawer: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          //移除抽屉菜单顶部默认留白
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
                    child: Center(child: Text("不限"),),
                    color: Colors.red[400],
                  ),
                  onTap: () {
                    setState(() {
                      category = 0;
                      categoryIndex = 0;
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
                          category = 1;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[1][2]),
                      onTap: () {
                        setState(() {
                          category = 1;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[1][3]),
                      onTap: () {
                        setState(() {
                          category = 1;
                          categoryIndex = 3;
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
                          category = 2;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][2]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][3]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][4]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][5]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][6]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][7]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 7;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[2][8]),
                      onTap: () {
                        setState(() {
                          category = 2;
                          categoryIndex = 8;
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
                          category = 3;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][2]),
                      onTap: () {
                        setState(() {
                          category = 3;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][3]),
                      onTap: () {
                        setState(() {
                          category = 3;
                          categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][4]),
                      onTap: () {
                        setState(() {
                          category = 3;
                          categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][5]),
                      onTap: () {
                        setState(() {
                          category = 3;
                          categoryIndex = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[3][6]),
                      onTap: () {
                        setState(() {
                          category = 3;
                          categoryIndex = 6;
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
                          category = 4;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[4][2]),
                      onTap: () {
                        setState(() {
                          category = 4;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[4][3]),
                      onTap: () {
                        setState(() {
                          category = 4;
                          categoryIndex = 3;
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
                          category = 5;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[5][2]),
                      onTap: () {
                        setState(() {
                          category = 5;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[5][3]),
                      onTap: () {
                        setState(() {
                          category = 5;
                          categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[5][4]),
                      onTap: () {
                        setState(() {
                          category = 5;
                          categoryIndex = 4;
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
                          category = 6;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[6][2]),
                      onTap: () {
                        setState(() {
                          category = 6;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[6][3]),
                      onTap: () {
                        setState(() {
                          category = 6;
                          categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[6][4]),
                      onTap: () {
                        setState(() {
                          category = 6;
                          categoryIndex = 4;
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
                          category = 7;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[7][2]),
                      onTap: () {
                        setState(() {
                          category = 7;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[7][3]),
                      onTap: () {
                        setState(() {
                          category = 7;
                          categoryIndex = 3;
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
                          category = 8;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[8][2]),
                      onTap: () {
                        setState(() {
                          category = 8;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[8][3]),
                      onTap: () {
                        setState(() {
                          category = 8;
                          categoryIndex = 3;
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
                          category = 9;
                          categoryIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][2]),
                      onTap: () {
                        setState(() {
                          category = 9;
                          categoryIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][3]),
                      onTap: () {
                        setState(() {
                          category = 9;
                          categoryIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][4]),
                      onTap: () {
                        setState(() {
                          category = 9;
                          categoryIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][5]),
                      onTap: () {
                        setState(() {
                          category = 9;
                          categoryIndex = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(categories[9][6]),
                      onTap: () {
                        setState(() {
                          category = 9;
                          categoryIndex = 6;
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
                          category = 10;
                          categoryIndex = 1;
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
      floatingActionButton: FloatingActionButton( //悬浮按钮
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardPage()));
          }
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: TabBarView(
          controller: _tabController,
          children: tabs.map((e) { //创建Tab页
            if (e == "全部") {
              return Expanded(
                child: Scrollbar(
                  child: CardsWidget(category: category, categoryIndex: categoryIndex,)
                )
              );
            } else if (e == "视频") {
              return Expanded(
                child: Scrollbar(
                  child: CardsWidget(category: category, categoryIndex: categoryIndex, types: 1,)
                )
              );
            } else if (e == "音频") {
              return Expanded(
                child: Scrollbar(
                  child: CardsWidget(category: category, categoryIndex: categoryIndex, types: 2,)
                )
              );
            } else if (e == "图片") {
              return Expanded(
                child: Scrollbar(
                  child: CardsWidget(category: category, categoryIndex: categoryIndex, types: 3,)
                )
              );
            } else if (e == "文章") {
              return Expanded(
                child: Scrollbar(
                  child: CardsWidget(category: category, categoryIndex: categoryIndex, types: 4,)
                )
              );
            }
          }).toList(),
        ),
      )
    );
  }
}