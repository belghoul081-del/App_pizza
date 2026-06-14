import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/view/profile/widget/widget_clipper.dart';
import 'package:app_pizza_client/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    final clientInf = Client_Model();
    return Scaffold(
      appBar: Widget_appBar(
        context,
        title: 'account',
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.heightPct(2),
          right: context.heightPct(2),
          bottom: context.heightPct(4),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            ///container
            Padding(
              padding: EdgeInsets.only(top: context.heightPct(17)),
              child: widget_ClipPath(context,clientInf),
            ),

            ///image
            Padding(
              padding: EdgeInsets.only(top: context.heightPct(4.5)),
              child: Container(
                height: context.heightPct(25),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  child: Image.asset(
                    clientInf.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
