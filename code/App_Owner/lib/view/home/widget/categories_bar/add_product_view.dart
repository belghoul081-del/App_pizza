import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_image.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
import 'package:app_pizza_owner/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';

class Add_Product_Page extends StatefulWidget {
  final Products_model product;
  const Add_Product_Page({super.key, required this.product});

  @override
  State<Add_Product_Page> createState() => _Add_Product_PageState();
}

class _Add_Product_PageState extends State<Add_Product_Page> {
  bool isOpened = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_appBar(context, title: "product details"),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.heightPct(10),
            left: context.heightPct(2),
            right: context.heightPct(2),
          ),
          child: Container(
            height: double.infinity,
            width: context.widthPct(90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              border: Border.all(
                color: ColorApp_Icon_border.bottonbrown,
                width: context.heightPct(0.5),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
                opacity: 0.40,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.heightPct(1)),
                  child: Widget_Images_Cards(
                    context,
                    image: widget.product.imagePath,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.heightPct(2)),
                  child: DashedLineDivider(
                    height: 5,
                    dashWidth: 3,
                    dashSpace: 0,
                    color: ColorApp_Icon_border.bottonbrown,
                  ),
                ),
                Row(
                  children: [
                    Botton_of_avlide_or_not(
                      context,
                      isOpened: true,
                      onChanged: (value) {
                        setState(() {
                          isOpened = value;
                        });
                      },
                    ),
                    Text("data"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget Botton_of_avlide_or_not(
  BuildContext context, {
  required ValueChanged<bool> onChanged,
  required bool isOpened,
}) {
  return Transform.scale(
    scale: context.heightPct(0.2),
    child: Switch(
      value: isOpened,
      onChanged: onChanged,
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
