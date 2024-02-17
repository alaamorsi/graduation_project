import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black54,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black45,
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 30.0
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blueGrey,
    elevation: 20.0,
    backgroundColor: Colors.black54,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  ),
  canvasColor: Colors.white,
  primaryColor: Colors.black,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  cardColor: Colors.blueGrey,
  dialogBackgroundColor: Colors.white10,
  dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme:InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white,),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.white, width: 2.0,),
        ),
      ),
      textStyle: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w300),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.black),
      side: MaterialStatePropertyAll(BorderSide(color: Colors.white)),
    ),
  ),
);


///////////////////light mode
ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    elevation: 20.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
  ),
  ),
  canvasColor: Colors.blue,
  primaryColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  cardColor: Colors.blue,
  dialogBackgroundColor: Colors.white,
  dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme:InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black,),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black, width: 2.0,),
        ),
      ),
    textStyle: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w300),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.white),
      side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
    ),
  ),
);

