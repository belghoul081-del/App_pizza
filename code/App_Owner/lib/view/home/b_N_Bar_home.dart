import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

// Widget bottomNavigationBar_home(
//   BuildContext context,
//   int _currentIndex,
//   ValueChanged<int> ontap,
// ) {
//   return NavigationBarTheme(
//     data: NavigationBarThemeData(
//       backgroundColor: ColorApp_Background.appbarecolor,
//       indicatorColor: const Color.fromARGB(0, 0, 0, 0),
//       iconTheme: WidgetStateProperty.resolveWith((states) {
//         if (states.contains(WidgetState.selected)) {
//           return IconThemeData(
//             color: ColorApp_Icon_border.bottonbrown,
//             size: context.heightPct(5),
//           );
//         }
//         return IconThemeData(
//           color: ColorApp_Icon_border.bottonbrown,
//           size: context.heightPct(4.5),
//         );
//       }),
//     ),
//     child: NavigationBar(
//       selectedIndex: _currentIndex,
//       onDestinationSelected: ontap,
//       labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
//       height: context.heightPct(7.5),
//       destinations: [
//         const NavigationDestination(
//           icon: Icon(Icons.data_saver_off_sharp),
//           label: '',
//         ),
//         const NavigationDestination(icon: Icon(Icons.home_sharp), label: ''),
//         const NavigationDestination(icon: Icon(Icons.chat_outlined), label: ''),
//       ],
//     ),
//   );
// }

Widget bottomNavigationBar_home(
  BuildContext context,
  int _currentIndex,
  Function(int) ontap,
) {
  return BottomAppBar(
    height: context.heightPct(9),
    color: ColorApp_Background.appbarecolor,
    shape: const CircularNotchedRectangle(),
    notchMargin: 8.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.data_saver_off_sharp,
                color: ColorApp_Icon_border.bottonbrown,

                size: context.heightPct(5),
              ),
              onPressed: () => ontap(0),
            ),
            SizedBox(width: context.heightPct(1)),
            IconButton(
              icon: Icon(
                Icons.home_sharp,
                color: ColorApp_Icon_border.bottonbrown,

                size: context.heightPct(5),
              ),
              onPressed: () => ontap(1),
            ),
          ],
        ),
        const SizedBox(width: 40),
        IconButton(
          icon: Icon(
            Icons.chat_outlined,
            color: ColorApp_Icon_border.bottonbrown,
            size: context.heightPct(5),
          ),
          onPressed: () => ontap(2),
        ),
      ],
    ),
  );
}
