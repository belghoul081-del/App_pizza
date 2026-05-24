import 'package:app_pizza_client/constant/app_color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      appBar: AppBar(backgroundColor: AppColor.appbarecolor),
      body: Column(
        children: [
          Container(
            child: Text(
              "hello i'm king",
              style: TextStyle(
                color: AppColor.textbrown,
                fontWeight: FontWeight.w900,
                fontSize: 50,
              ),
            ),
          ),
          Container(height: 100, width: 100, color: AppColor.botounOrange),
          Text(
            "hello gghg",
            style: TextStyle(
              color: AppColor.textblack,
              fontWeight: FontWeight.w900,
              fontSize: 50,
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColor.spaceofwrite_info_massege,
              border: Border.all(color: AppColor.textbrown, width: 5),
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(color: AppColor.chate_massege),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(color: AppColor.white),
          ),
          Text(
            "you can't .by",
            style: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.w900,
              fontSize: 50,
            ),
          ),
        ],
      ),
    );
  }
}
