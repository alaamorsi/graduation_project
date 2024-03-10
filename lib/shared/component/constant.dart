import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

bool mode = true;
bool notification = true;
String langTitle = 'Arabic';
String appBarLogo = "Assets/appBarLogo.png";
late double screenHeight;
late double screenWidth;
var font= GoogleFonts.changa();

//user data
String? jwt = '';
String? role = '';
