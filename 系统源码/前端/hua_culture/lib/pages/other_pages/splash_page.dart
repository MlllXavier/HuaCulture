import 'package:flutter/material.dart';
import 'package:hua_culture/public/config.dart';
import 'package:hua_culture/widgets/bottom_appbar_demo.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() { 
    super.initState();
    
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomAppBarDemo()), 
          (route) => route == null
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    screenSize.widght = MediaQuery.of(context).size.width;
    screenSize.height = MediaQuery.of(context).size.height;

    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        "images/wenhua.jpg",
        scale: 2.0,
        fit: BoxFit.cover,
      ),
    );
  }
}