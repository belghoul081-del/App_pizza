import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:flutter/material.dart';

Widget Bar_Location_Notificaion_Bccount({required BuildContext context}) {
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
                size: context.heightPct(7),
              ),
              Expanded(
                child: Text(
                  "siamitale , 400",
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
            onPressed: () {},
            child: Icon(
              Icons.notifications_none_rounded,
              color: ColorApp_Botton.bottonOrange,
              size: context.heightPct(7),
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
