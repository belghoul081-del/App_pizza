import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/client/client_Model.dart';
import 'package:flutter/material.dart';

Widget general_card_cart(BuildContext context) {
  return InkWell(
    onTap: () {
      // Navigator.of(
      //   context,
      // ).push(MaterialPageRoute(builder: (context) => Message_page(information_Client: Client_Model(),)));
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
                    image: AssetImage(Client_Model().image),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: context.heightPct(0.5),
                bottom: context.heightPct(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Client_Model().name,
                    style: TextStyle(
                      fontFamily: "InterBold",
                      fontSize: context.heightPct(2),
                    ),
                  ),
                  Text(
                    "ID: ${Client_Model().number}",
                    style: TextStyle(
                      fontFamily: "InterBold",
                      fontSize: context.heightPct(1.5),
                    ),
                  ),
                  Text(
                    "number: ${Client_Model().number}",
                    style: TextStyle(
                      fontFamily: "InterBold",
                      fontSize: context.heightPct(1.5),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: context.heightPct(7),
                  width: context.heightPct(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  ),
                ),
                SizedBox(width: context.heightPct(1)),
                Container(
                  height: context.heightPct(7),
                  width: context.heightPct(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
