import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'AppScannerActivity.dart';
import 'Utils/AppColors.dart';


class SplashActivity extends StatefulWidget {
  @override
  SplashActivityState createState() => new SplashActivityState();
}

class SplashActivityState extends State<SplashActivity>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;



  Timer timer;
  startTime() async {
    var _duration = new Duration(seconds: 3);
    timer = new Timer(_duration, navigationPage);
    return timer;
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void navigationPage() {

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => AppScannerActivity()));

  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 50.0, end: 200.0).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          print("completed");
        } else if (state == AnimationStatus.dismissed) {
          print("dismissed");
        }
      })
      ..addListener(() {
        print("value:${_animation.value}");
        setState(() {});
      });
    _controller.forward();
    startTime();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          /*decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/ic_splash_screen1.png'),
              fit: BoxFit.cover,
            ),
          ),*/

          color: AppColors.grayText,

          child: Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsets.only(top: 50.0),
            child: Transform.rotate(
              angle: -2 * pi * _animation.value / 200,
              child: Image.asset(
                ImagePath.FLUTTER_OPEN,
                fit: BoxFit.fitHeight,
                width: _animation.value,
                height: _animation.value,
              ),
            ),
          ),
        ),


      ),
    );
  }
}
class ImagePath {
  static const _PATH = "assets/images";
  static const FLUTTER_OPEN = "$_PATH/ic_logo.png";

}
