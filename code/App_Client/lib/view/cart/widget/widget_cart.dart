import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/view/cart/widget/widget_container.dart';
import 'package:app_pizza_client/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';

Widget widget_Card_Cart(BuildContext context,{required VoidCallback onAdd,
required VoidCallback onRemove,
required int quantity,required int price,required String imagePath,required String name}) {

  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(left: context.widthPct(1)),
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: context.heightPct(0.5),
              bottom: context.heightPct(0.5),
              right: context.heightPct(1),
              left: context.heightPct(8),
            ),
            height: context.heightPct(17),
            width: context.widthPct(75),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                ).scale(1.5),
              ],

              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: const Color(0xFFFFF0DB),
            ),
            child: widget_Container_ofCart(
              context,
              onAdd: onAdd,
              onRemove: onRemove,
              quantity: quantity, price: price,
              name:name
            ),
          ),

          Positioned(
            right: context.widthPct(58),
            child: Widget_Images_Cards(
              context,
              image: imagePath,
              size: 15,
            ),
          ),
        ],
      ),
    ),
  );
}
