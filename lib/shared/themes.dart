import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:hexcolor/hexcolor.dart';


////////////////////dark mode
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#101010"),
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor("#008080"),
    elevation: 20.0,
    selectedItemColor: HexColor("#008080"),
    unselectedItemColor: HexColor("#c0c0c0"),
    type: BottomNavigationBarType.fixed,
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
  canvasColor: HexColor("#c0c0c0"),
  primaryColor: HexColor("#101010"),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  cardColor: HexColor("#008080"),
  dialogBackgroundColor: HexColor("#666666"),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme:InputDecorationTheme(
        labelStyle: font.copyWith(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white,),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        enabledBorder:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.white, width: 2.0,),
        ),
      ),
      textStyle: font.copyWith(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w300),
    menuStyle: const MenuStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.black),
      side: MaterialStatePropertyAll(BorderSide(color: Colors.white)),
    ),
  ),
);


///////////////////light mode
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("#f5f5f5"),
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor("#000080"),
    elevation: 20.0,
    selectedItemColor: HexColor("#000080"),
    unselectedItemColor: HexColor("#666666"),
    type: BottomNavigationBarType.fixed,
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
  canvasColor: HexColor("#000080"),
  primaryColor: HexColor("#f5f5f5"),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  cardColor: HexColor("#000080"),
  dialogBackgroundColor: HexColor("#f5f5f5"),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme:InputDecorationTheme(
        labelStyle: font.copyWith(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black,),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black, width: 2.0,),
        ),
      ),
    textStyle: font.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w300),
    menuStyle: const MenuStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.white),
      side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
    ),
  ),
);

