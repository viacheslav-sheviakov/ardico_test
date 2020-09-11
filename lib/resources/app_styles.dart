import 'package:flutter/material.dart';

class AppStyles {
  static const splashTitle = TextStyle(
    color: Colors.white,
    fontSize: 32.0,
    fontWeight: FontWeight.w300,
  );

  static const appButtonText = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    letterSpacing: 2.0,
  );

  static const bottomBarButton = TextStyle(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );

  static const bottomBarShadows = [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, -2.0),
      blurRadius: 8.0,
      spreadRadius: 4.0,
    ),
  ];
}
