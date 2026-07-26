import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget Bar_Location_Notificaion_Account({required BuildContext context , 
}) {
  final orderProvider = Provider.of<OrderProvider>(context);
  final bool hasUnread = orderProvider.allOrders.any((o) => !o.readByOwner);

  return Container(
    margin: EdgeInsets.symmetric(vertical: context.heightPct(1)),
    padding: EdgeInsets.symmetric(horizontal: context.heightPct(2)),
    height: context.heightPct(8),
    width: context.widthPct(100),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: context.heightPct(24),
          child: Row(
            children: [
              ///Location
              Icon(
                Icons.location_on_outlined,
                color: ColorApp_Botton.bottonOrange,
                size: context.heightPct(7),
              ),
              Expanded(
                child: Text(
                  "cyamitale -400",
                  style: TextStyle(
                    color: ColorApp_Text.textbrown,
                    fontSize: context.heightPct(2.4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        ///notifivation
        Container(
          width: context.heightPct(8),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed("Notification");
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: ColorApp_Botton.bottonOrange,
                  size: context.heightPct(7),
                ),
                if (hasUnread)
                  Positioned(
                    right: 6,
                    top: 10,
                    child: Container(
                      width: context.heightPct(1.5),
                      height: context.heightPct(1.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        ///Account
        Container(
          width: context.heightPct(8),
          height: context.heightPct(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: ColorApp_Botton.bottonOrange),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/profila_pucture.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(19)),
                      onTap: () {
                        Navigator.of(context).pushNamed("Profile");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
