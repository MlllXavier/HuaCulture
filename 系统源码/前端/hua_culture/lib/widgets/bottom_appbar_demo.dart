import 'package:flutter/material.dart';
import 'package:hua_culture/pages/main_pages/home_page.dart';
import 'package:hua_culture/pages/main_pages/intro_page.dart';
import 'package:hua_culture/pages/main_pages/user_page.dart';

class BottomAppBarDemo extends StatefulWidget {
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo>{
  int _currentIndex = 0;
  List<Widget> pages = List();

  @override
  void initState() { 
    super.initState();
    pages..add(HomePage())..add(IntroPage())..add(UserPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.home), 
                color: Colors.white, 
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                }),
            IconButton(
                icon: Icon(Icons.text_snippet),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                }),
            IconButton(
                icon: Icon(Icons.account_box_sharp),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

