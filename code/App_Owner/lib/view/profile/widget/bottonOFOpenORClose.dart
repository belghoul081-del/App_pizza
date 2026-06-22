import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

class SwitchOpenORClose extends StatefulWidget {
  const SwitchOpenORClose({super.key});

  @override
  State<SwitchOpenORClose> createState() => _SwitchOpenORCloseState();
}

class _SwitchOpenORCloseState extends State<SwitchOpenORClose> {
  bool isOpened = true;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: context.heightPct(0.2),
      child: Switch(
        value: isOpened,
        onChanged: (value) {
          setState(() {
            isOpened = value;
          });
        },
        trackOutlineColor: WidgetStateProperty.all(
          ColorApp_Icon_border.bottonbrown,
        ),
        trackOutlineWidth: WidgetStateProperty.all(1),
        inactiveTrackColor: ColorApp_Background.appbarecolor,
        activeThumbColor: const Color.fromARGB(255, 253, 189, 100),

        thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(
              Icons.meeting_room,
              color: ColorApp_Icon_border.bottonbrown,
              size: 20,
            ); // باب مفتوح
          }
          return const Icon(
            Icons.door_back_door,
            color: ColorApp_Background.appbarecolor,
            size: 20,
          ); // باب مغلق
        }),

        thumbColor: WidgetStateProperty.all(
          isOpened
              ? ColorApp_Botton.bottonOrange
              : ColorApp_Icon_border.bottonbrown,
        ),
      ),
    );
  }
}
