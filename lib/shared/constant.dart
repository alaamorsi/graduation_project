import 'package:flutter/material.dart';

bool mode = true;
String logoImage = mode?"Assets/logo1.png":"Assets/logo2.png";
void getThemeMode(ThemeMode M){
  if(M == ThemeMode.light)
  {
    mode = true;
  }
  else if(M == ThemeMode.dark)
  {
    mode = false;
  }
}