import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

class Store_Closed_Page extends StatelessWidget {
  const Store_Closed_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorApp_Background.backgroundcolor,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Positioned.fill(child: AppImage_background()),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.heightPct(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/close_store.png",
                        fit: BoxFit.fitHeight,
                        height: context.heightPct(40),
                      ),
                      SizedBox(height: context.heightPct(3)),
                      SizedBox(
                        height: context.heightPct(4),
                      ), // Spacing below sign
                      
                      Text(
                        "STORE HOURS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "InterBold",
                          // Larger, bold font
                          fontSize: context.heightPct(3.5),
                          color: ColorApp_Text.textbrown,
                        ),
                      ),
                      SizedBox(height: context.heightPct(1.5)), // Spacing
                   
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "DAILY:",
                              style: TextStyle(
                                fontSize: context.heightPct(2),
                                fontFamily: "InterBold",
                                color: const Color.fromARGB(255, 219, 128, 1),
                              ),
                            ),
                            TextSpan(
                              text: " 11:00 AM - 12:00 AM (Midnight)",
                              style: TextStyle(
                                fontSize: context.heightPct(2),
                                color: ColorApp_Text.textbrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(0.5)),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "TUESDAY:",
                              style: TextStyle(
                                fontSize: context.heightPct(2),
                                fontFamily: "InterBold",
                                color: const Color.fromARGB(255, 219, 128, 1),
                              ),
                            ),
                            TextSpan(
                              text: " CLOSED",
                              style: TextStyle(
                                fontSize: context.heightPct(2),
                                color: ColorApp_Text.textbrown,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: context.heightPct(4),
                      ), // Spacing below hours
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
