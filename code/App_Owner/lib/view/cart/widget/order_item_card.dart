import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/order/order_item_Model.dart';
import 'package:app_owner/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';

/// نفس تصميم كارد السلة عند العميل، لكن للعرض فقط (بدون أزرار +/- وبدون

Widget Widget_Order_Item_Card(
  BuildContext context, {
  required OrderItem_Model item,
}) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(
        left: context.widthPct(1),
        top: context.heightPct(1),
        bottom: context.heightPct(1),
      ),
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
                  offset: const Offset(0, 0),
                  spreadRadius: 1,
                ).scale(1.5),
              ],
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: const Color(0xFFFFF0DB),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: context.widthPct(6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: context.heightPct(3),
                      fontFamily: "InriaSerif",
                      color: ColorApp_Text.textblack,
                    ),
                  ),
                  if (item.supplements.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        left: context.heightPct(2),
                        bottom: context.heightPct(1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.supplements.map((s) {
                          // التحقق مما إذا كان السعر أكبر من 0 لعرضه
                          String priceText = s.price > 0
                              ? " (${s.price} Da)"
                              : "";
                          return Text(
                            "- ${s.name}$priceText",
                            style: TextStyle(
                              fontSize: context.heightPct(
                                1.8,
                              ),
                              color: Colors.grey[800],
                              fontFamily: "SemiBold",
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item.totalPrice} Da",
                        style: TextStyle(
                          fontSize: context.heightPct(2.5),
                          fontFamily: "SemiBold",
                          color: ColorApp_Text.textbrown,
                        ),
                      ),
                      Container(
                        height: context.heightPct(4),
                        width: context.widthPct(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: ColorApp_Botton.bottonOrange,
                        ),
                        child: Text(
                          "x${item.quantity}",
                          style: TextStyle(
                            fontSize: context.heightPct(2.5),
                            fontFamily: "SemiBold",
                            color: ColorApp_Text.textblack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: context.widthPct(58),
            child: Widget_Images_Cards(
              context,
              image: item.imagePath,
              size: 15,
            ),
          ),
        ],
      ),
    ),
  );
}
