import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/////////////////////////////////////////////////////////////////////////////////////////
/////////Light Themes

ThemeData orangeTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#FF4500"),  //OrangeRed //for first items
  cardColor: HexColor("#FF6700"), //Neon Orange //for second items
  canvasColor: HexColor("#FF8040"), //Mango Orange // for third items
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
);

ThemeData greenTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#056608"),  //Deep Green //for first items
  cardColor: HexColor("#08A04B"),  //Irish Green //for first items
  canvasColor: HexColor("#54c571"), //Zombie Green // for third items
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
);

ThemeData blueTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#1589FF"), //Neon Blue
  cardColor: HexColor("#5CB3FF"), //Crystal Blue
  canvasColor: HexColor("#ADDFFF"), //Light Day Blue
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
);

ThemeData purpleTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#fbfbf9"), //Cotton
  primaryColor: HexColor("#9933ff"),
  cardColor: HexColor("#cc99ff"),
  canvasColor: HexColor("#9172EC"), //Crocus Purple
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
);



/////////////////////////////////////////////////////////////////////////////////////////
/////////Dark Themes

ThemeData orangeDarkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#2C3539"), //Gunmetal
  primaryColor: HexColor("#FF4500"),  //OrangeRed //for first items
  cardColor: HexColor("#FF6700"), //Neon Orange //for second items
  canvasColor: HexColor("#FF8040"), //Mango Orange // for third items
  primaryColorDark: Colors.white,
  primaryColorLight: Colors.black,
);

ThemeData greenDarkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black, //Gunmetal
  primaryColor: HexColor("#056608"),  //Deep Green //for first items
  cardColor: HexColor("#08A04B"),  //Irish Green //for first items
  canvasColor: HexColor("#54c571"), //Zombie Green // for third items
  primaryColorDark: Colors.white,
  primaryColorLight: HexColor("#2C3539"),
);

ThemeData blueDarkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#2C3539"), //Gunmetal
  primaryColor: HexColor("#1589FF"), //Neon Blue
  cardColor: HexColor("#5CB3FF"), //Crystal Blue
  canvasColor: HexColor("#ADDFFF"),
  primaryColorDark: Colors.white,
  primaryColorLight: Colors.black,
);

ThemeData purpleDarkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#2C3539"), //Gunmetal
  primaryColor: HexColor("#9933ff"),
  cardColor: HexColor("#cc99ff"),
  canvasColor: HexColor("#9172EC"), //Crocus Purple
  primaryColorDark: Colors.white,
  primaryColorLight: Colors.black,
);

