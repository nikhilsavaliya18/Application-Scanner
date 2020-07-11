import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {

  static const Color accent = const Color(0xFFFE8484);
  static const Color primary = const Color(0xfffE8484);
  static const Color grey = const Color(0xFF585858);
  static const Color grayText = const Color(0xB36A6A6A);
  static const Color formborder = const Color(0xFFCBCACA);
  static const Color black = const Color(0xFF000000);
  static const Color white = const Color(0xFFffffff);
  static const Color lightblue = const Color(0xFFE8F3FF);
  static const Color secondary = const Color(0xFF440F09);
  static const Color bgColor = const Color(0xBFf9f9f9);
  static const Color whiteTransparent = const Color(0xBFFFFFFF);
  static const Color priceControl = const Color(0xff39A70D);
  static const Color blackTransparent = const Color(0x60000000);
  static const Color textColor = const Color(0xFFffffff);
  static const Color bottomUnslected = const Color(0xFF999999);
  static const Color dividerColor = const Color(0xFFE3E9EC);
  static const Color receiveColor = const Color(0xFF008409);


  static const LinearGradient buttonGradient_ui = const LinearGradient(
      colors: [ primary, accent],
      end: Alignment.topLeft,
      begin: Alignment.bottomRight);
  static const LinearGradient buttonGradient = const LinearGradient(
      colors: [accent,primary],
      end: Alignment.topLeft,
      begin: Alignment.bottomRight);

  static const LinearGradient trasparantGradiant = const LinearGradient(
      colors: [Colors.transparent,Colors.transparent],
      end: Alignment.topLeft,
      begin: Alignment.bottomRight);



}