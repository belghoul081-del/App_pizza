import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/provider/admin/admin_provider.dart';
import 'package:app_pizza_client/provider/client/client_Provider.dart';
import 'package:app_pizza_client/provider/order/order_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget Bar_Location_Notificaion_Bccount({required BuildContext context}) {
  final adminProvider = Provider.of<AdminProvider>(context);

  final clientInf = Provider.of<ClientProvider>(context).client;
  final bool isNetwork =
      clientInf.image.startsWith('http://') ||
      clientInf.image.startsWith('https://');
  final orderProvider = Provider.of<OrderProvider>(context);
  final bool hasUnreadNotification = orderProvider.hasUnreadNotification;

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
              Icon(
                Icons.location_on_outlined,
                color: ColorApp_Botton.bottonOrange,
                size: context.heightPct(6.5),
              ),
              Expanded(
                child: Text(
                  adminProvider.admin.address,
                  style: TextStyle(
                    color: ColorApp_Text.textbrown,
                    fontSize: context.heightPct(2.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
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
                // التحقق من وجود إشعارات غير مقروءة
                if (hasUnreadNotification)
                  Positioned(
                    right: 6, 
                    top: 10,
                    child: Container(
                      width: context.heightPct(1.5), 
                      height: context.heightPct(1.5), 
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red, 
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
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
                  child: isNetwork
                      ? Image.network(clientInf.image, fit: BoxFit.cover)
                      : Image.asset(clientInf.image, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(19)),
                      onTap: () {
                        print("${clientInf.name} /// ${clientInf.number}");
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
