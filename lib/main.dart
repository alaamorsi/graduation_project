import 'package:flutter/material.dart';
import 'package:graduation_project/modules/splash.dart';
import 'package:graduation_project/shared/constant.dart';
import 'package:graduation_project/shared/themes.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mode?ThemeMode.light:ThemeMode.dark,
      home:splash(),
    );
  }
}
