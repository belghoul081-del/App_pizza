import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';

class FeatureUnavailablePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const FeatureUnavailablePage({
    super.key,
    this.title = "This feature is currently unavailable.",
    this.subtitle = "If you give me the money later, I will open it for you. 😁",
    this.icon = Icons.construction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.heightPct(20)),
            child: Container(
              height: context.heightPct(20),
              width: context.heightPct(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: const Color.fromARGB(255, 255, 222, 177),
              ),
              child: Center(
                child: Icon(
                  Icons.construction,
                  color: const Color.fromARGB(255, 255, 149, 0),
                  size: context.heightPct(7),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.heightPct(2),
              bottom: context.heightPct(0.5),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "InterBold",
                  fontSize: context.heightPct(3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.heightPct(0.5),
              bottom: context.heightPct(10),
              left: context.heightPct(3),
              right: context.heightPct(3),
            ),
            child: Center(
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  wordSpacing: 1,
                  fontFamily: "Inter",
                  fontSize: context.heightPct(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Widget_botton(
            context,
            text: "Back",
            onPressed: () {
              Navigator.pop(context);
            },
            height: 7,
            width: 80,
            backgroundColor: ColorApp_Botton.bottonOrange,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
