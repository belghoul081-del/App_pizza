import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget bottomNavigationBar_home(
  BuildContext context,
  int _currentIndex,
  ValueChanged<int> ontap,
) {
  return NavigationBarTheme(
    data: NavigationBarThemeData(
      backgroundColor: ColorApp_Background.appbarecolor,
      indicatorColor: const Color.fromARGB(0, 0, 0, 0),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: ColorApp_Icon_border.bottonbrown,
            size: context.heightPct(5),
          );
        }
        return IconThemeData(
          color: ColorApp_Icon_border.bottonbrown,
          size: context.heightPct(4.5),
        );
      }),
    ),
    child: NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: ontap,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: context.heightPct(7.5),
      destinations: [
        NavigationDestination(icon: Icon(Icons.home_sharp), label: ''),
        NavigationDestination(
          icon: SizedBox(
            height: context.heightPct(10),
            width: context.heightPct(10),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -context.heightPct(5),
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: context.heightPct(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      shape: CircleBorder(),
                      onPressed: () {
                        Navigator.of(context).pushNamed("order");
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: ColorApp_Background.appbarecolor,
                        size: context.heightPct(7.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          label: '',
        ),

        NavigationDestination(icon: Icon(Icons.chat_outlined), label: ''),
      ],
    ),
  );
}
