import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appbarecostume_I(
  BuildContext context,
  TabController _tabController,
) {
  return AppBar(
    flexibleSpace: SafeArea(child: Stack(children: [choise_images(context)])),
    toolbarHeight: context.heightPct(17),
    bottom: TabBar(
      controller: _tabController,
      labelColor: ColorApp_Botton.bottonOrange,
      indicatorColor: ColorApp_Botton.bottonOrange,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: context.heightPct(0.4),
      indicatorPadding: EdgeInsets.symmetric(horizontal: context.heightPct(3)),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: context.heightPct(3.5),
      ),
      tabs: [Tab(text: "Sigin In")],
    ),
  );
}

PreferredSizeWidget appbarecostume_II(
  BuildContext context,
  TabController _tabController,
) {
  return AppBar(
    toolbarHeight: context.heightPct(1),
    bottom: TabBar(
      controller: _tabController,
      labelColor: ColorApp_Botton.bottonOrange,
      indicatorColor: ColorApp_Botton.bottonOrange,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: context.heightPct(0.4),
      indicatorPadding: EdgeInsets.symmetric(horizontal: context.heightPct(3)),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: context.heightPct(3.5),
      ),
      tabs: [Tab(text: "Sigin In")],
    ),
  );
}

Positioned choise_images(BuildContext context) {
  return Positioned(
    top: -context.heightPct(17.5),
    left: -context.heightPct(17.5),
    child: RotatedBox(
      quarterTurns: 1,
      child: Image.asset(
        "assets/images/login_images/logo_pizza.png",
        height: context.heightPct(35),
      ),
    ),
  );
}
