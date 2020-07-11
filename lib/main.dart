import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_appavailability/flutter_appavailability.dart';

import 'SplashScreen.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: new SplashActivity(),

    );
  }
}