import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_owner/view/cart/widget/widget_container.dart';
import 'package:app_pizza_owner/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';

Widget widget_Card_Cart(
  BuildContext context, {
  required VoidCallback onAdd,
  required VoidCallback onRemove,
  required VoidCallback delete_press,
  required int quantity,
  required int price,
  required String imagePath,
  required String name,
  required List<Sepliment_model> sepliment,
}) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(left: context.widthPct(1)),
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(right: context.heightPct(1)),
            padding: EdgeInsets.only(
              top: context.heightPct(0.5),
              bottom: context.heightPct(0.5),
              right: context.heightPct(1),
              left: context.heightPct(8),
            ),
            constraints: BoxConstraints(minHeight: context.heightPct(17)),
            width: context.widthPct(80),
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
              quantity: quantity,
              price: price,
              name: name,
              sepliment: sepliment,
            ),
          ),

          Positioned(
            right: context.widthPct(58),
            child: Widget_Images_Cards(context, image: imagePath, size: 15),
          ),
          Positioned(
            top: -context.heightPct(1),
            right: -context.widthPct(4),
            child: GestureDetector(
              onTap: delete_press,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                padding: EdgeInsets.all(3),

                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
