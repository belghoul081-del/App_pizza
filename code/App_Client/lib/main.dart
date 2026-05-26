import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/view/home/home_view.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        fontFamily: "Inter",
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor_Background.appbarecolor,
        ),
        scaffoldBackgroundColor: AppColor_Background.backgroundcolor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor_Background.appbarecolor,
        ),
      ),
      home: HomePage(),
      routes: {
        "HomePage": (context) => HomePage(),
        //"Account": (context) => Account(),
      },
    );
  }
}
