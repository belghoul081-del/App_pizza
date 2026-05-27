import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/view/home/home_view.dart';
import 'package:app_pizza_client/view/start/loading_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        appBarTheme: AppBarTheme(
          backgroundColor: ColorApp_Background.appbarecolor,
        ),
        scaffoldBackgroundColor: ColorApp_Background.backgroundcolor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorApp_Background.appbarecolor,
        ),
      ),
      home: Loading_Page(),
      routes: {
        "Home": (context) => Home_Page(),
        "Loading": (context) => Loading_Page(),
      },
    );
  }
}
