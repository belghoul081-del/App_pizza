import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/internet/connectivity_provider.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InterneC extends StatelessWidget {
  const InterneC({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivity = Provider.of<ConnectivityProvider>(
      context,
      listen: false,
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                    Icons.wifi_off_rounded,
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
                  "No internet connection",
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
                  "please check your internet connection and try again",
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
              text: "Retry",
              onPressed: () {
                connectivity.checkInternet();
              },
              height: 7,
              width: 80,
              backgroundColor: ColorApp_Botton.bottonOrange,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
