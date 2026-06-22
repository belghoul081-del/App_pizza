import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/view/home/widget/bottom_bar/navigationDestination_homr.dart';
import 'package:flutter/material.dart';

Widget bottomNavigationBar_home(
  BuildContext context,
  int _currentIndex,
  ValueChanged<int> ontap, {
  int? quantity,
}) {
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
        NavigationDestination_bar_home(context: context, x: 1),
        NavigationDestination_bar_home(
          context: context,
          x: 2,
          quantity: quantity,
        ),
        NavigationDestination_bar_home(context: context, x: 3),
      ],
    ),
  );
}
