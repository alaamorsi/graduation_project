import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData orangeTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#ff6700"),  //Neon Orange //for first items
  cardColor: HexColor("#fdbd01"), //Neon Gold //for second items
  canvasColor: HexColor("#fed8b1"), //Light Orange // for third items
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
);

ThemeData greenTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#16f529"),  //Neon Green //for first items
  cardColor: HexColor("#3ea055"), //Clover Green //for second items
  canvasColor: HexColor("#54c571"), //Zombie Green // for third items
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,

);

///////////////////light mode
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#008080"),
  cardColor: HexColor("#008080"),
  canvasColor: HexColor("#f5f5f5"),
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
  appBarTheme:  AppBarTheme(
    backgroundColor: HexColor("#000080"),
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: HexColor("#f5f5f5"),
      size: 30.0,
    ),
    elevation: 0.0,
    titleTextStyle: font.copyWith(
      color: HexColor("#f5f5f5"),
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: font.copyWith(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: font.copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: font.copyWith(
      fontSize: 15.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    labelSmall: font.copyWith(
      fontSize: 11.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),
);

////////////////////dark mode
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#101010"), //black
  primaryColor: HexColor("#000080"),
  cardColor: HexColor("#000080"),
  canvasColor: HexColor("#3d3635"), //Gray Brown
  primaryColorDark: Colors.white,
  primaryColorLight: Colors.black,
  appBarTheme:  AppBarTheme(
    backgroundColor: HexColor("#008080"),
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: HexColor("#f5f5f5"),
      size: 30.0,
    ),
    elevation: 0.0,
    titleTextStyle: font.copyWith(
      color: HexColor("#f5f5f5"),
      fontSize: 25.0,
      fontWeight: FontWeight.bold
    ),
  ),
  textTheme: TextTheme(
    titleLarge: font.copyWith(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: font.copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: font.copyWith(
      fontSize: 15.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    labelSmall: font.copyWith(
      fontSize: 11.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  ),
);




