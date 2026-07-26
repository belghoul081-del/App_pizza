import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/order/order_Model.dart';
import 'package:app_owner/provider/event/time.dart';
import 'package:app_owner/view/cart/pages/page_cart_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardOrder(BuildContext context, {required Order_Model order}) {
  final String timeLabel = order.createdAt != null
      ? Time_Calculate().getTimeAgo(order.createdAt!)
      : "--";
  final bool isNetwork = order.client.image.startsWith('http');

  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Page_Cart_Order(order: order)),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.heightPct(1),
        horizontal: context.heightPct(2),
      ),
      child: Container(
        height: context.heightPct(10),
        width: context.widthPct(80),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 241, 227),
          border: Border.all(color: ColorApp_Icon_border.bottonbrown),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: context.heightPct(0.5),
                right: context.heightPct(2),
              ),
              child: Container(
                height: context.heightPct(7.5),
                width: context.heightPct(7.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  image: DecorationImage(
                    image: isNetwork
                        ? NetworkImage(order.client.image) as ImageProvider
                        : AssetImage(order.client.image),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: context.heightPct(0.5),
                  bottom: context.heightPct(0.5),
                  right: context.heightPct(2.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.client.name,
                      style: TextStyle(
                        fontFamily: "InterBold",
                        fontSize: context.heightPct(2),
                      ),
                    ),
                    Text(
                      "Num: ${order.client.number}",
                      style: TextStyle(
                        fontFamily: "InterBold",
                        fontSize: context.heightPct(1.2),
                      ),
                    ),
                    Text(
                      "time : $timeLabel",
                      style: TextStyle(
                        fontFamily: "InterBold",
                        fontSize: context.heightPct(1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                buildOrderIconButton(context, order.status.imagePath, () {}),
                SizedBox(width: context.heightPct(1)),
                buildOrderIconButton(
                  context,
                  "assets/icons/order/Icon_QR.svg",
                  () {},
                ),
                SizedBox(width: context.heightPct(0.5)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildOrderIconButton(
  BuildContext context,
  String assetPath,
  VoidCallback onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(context.heightPct(1.2)),
      height: context.heightPct(7),
      width: context.heightPct(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorApp_Background.backgroundcolorII,
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
    ),
  );
}
