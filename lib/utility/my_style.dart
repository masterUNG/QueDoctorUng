import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.tealAccent.shade400;
  Color lightColor = Colors.lime.shade200;

  Widget mySizebox() => SizedBox(
        width: 16,
        height: 16,
      );

  Widget showLogo() => Image(image: AssetImage('images/logo.png'));

  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  Widget titleH2(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkColor,
        ),
      );

  Widget titleH3(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 14,
          color: darkColor,
        ),
      );

  MyStyle();
}
