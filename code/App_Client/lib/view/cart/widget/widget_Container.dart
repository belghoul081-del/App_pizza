import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget widget_Container_ofCart(
  BuildContext context, {
  required VoidCallback onAdd,
  required VoidCallback onRemove,
  required int quantity,
  required int price,
  required String name,
}) {
  return Padding(
    padding: EdgeInsets.only(left: context.widthPct(6)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: context.heightPct(3),
            fontFamily: "InriaSerif",
            color: ColorApp_Text.textblack,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${price} Da",
              style: TextStyle(
                fontSize: context.heightPct(2.5),
                fontFamily: "SemiBold",
                color: ColorApp_Text.textbrown,
              ),
            ),
            Botton_ADD_OR_SubTract(
              context,
              onAdd: onAdd,
              onRemove: onRemove,
              quantity: quantity,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget Botton_ADD_OR_SubTract(
  BuildContext context, {
  required VoidCallback onAdd,
  required VoidCallback onRemove,
  required int quantity,
}) {
  return Container(
    height: context.heightPct(4),
    width: context.widthPct(30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: ColorApp_Botton.bottonOrange,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: context.widthPct(8),
          child: MaterialButton(
            elevation: 0,
            minWidth: 0,
            splashColor: const Color.fromARGB(255, 170, 100, 3),
            highlightColor: const Color.fromARGB(255, 170, 100, 3),
            shape: CircleBorder(),
            padding: EdgeInsets.zero,
            onPressed: onRemove,
            child: Center(
              child: Icon(
                Icons.remove,
                size: context.heightPct(3),
                color: ColorApp_Text.textblack,
              ),
            ),
          ),
        ),

        Text(
          "${quantity}",
          style: TextStyle(
            fontSize: context.heightPct(2.5),
            fontFamily: "SemiBold",
            color: ColorApp_Text.textblack,
          ),
        ),
        SizedBox(
          width: context.widthPct(8),
          child: MaterialButton(
            elevation: 0,
            minWidth: 0,
            splashColor: const Color.fromARGB(255, 170, 100, 3),
            highlightColor: const Color.fromARGB(255, 170, 100, 3),
            shape: CircleBorder(),
            padding: EdgeInsets.zero,
            onPressed: onAdd,
            child: Center(
              child: Icon(
                Icons.add,
                size: context.heightPct(3),
                color: ColorApp_Text.textblack,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
