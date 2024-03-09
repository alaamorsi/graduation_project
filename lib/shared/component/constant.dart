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
late ImageProvider<Object> imageProvider;
// String firstName = CacheHelper.getData(key: 'firstName');
// String lastName = CacheHelper.getData(key: 'lastName');
// String? bio = CacheHelper.getData(key: 'biography');
// String email = CacheHelper.getData(key: 'email');
