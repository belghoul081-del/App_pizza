import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appbarecostume_I(
  BuildContext context,
  TabController _tabController,
) {
  return AppBar(
    flexibleSpace: SafeArea(
      child: Stack(children: [choise_images(context, _tabController.index)]),
    ),
    toolbarHeight: context.heightPct(17),
    bottom: TabBar(
      controller: _tabController,
      unselectedLabelColor: const Color.fromARGB(255, 255, 206, 137),
      labelColor: ColorApp_Botton.bottonOrange,
      dividerColor: const Color.fromARGB(0, 255, 162, 31),
      indicatorColor: ColorApp_Botton.bottonOrange,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: context.heightPct(3.5),
      ),
      tabs: [
        Tab(text: "Sigin In"),
        Tab(text: "Sigin Up"),
      ],
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
      unselectedLabelColor: const Color.fromARGB(255, 255, 206, 137),
      labelColor: ColorApp_Botton.bottonOrange,
      dividerColor: const Color.fromARGB(0, 255, 162, 31),
      indicatorColor: ColorApp_Botton.bottonOrange,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: context.heightPct(3.5),
      ),
      tabs: [
        Tab(text: "Sigin In"),
        Tab(text: "Sigin Up"),
      ],
    ),
  );
}

Positioned choise_images(BuildContext context, int choiseT) {
  if (choiseT == 0) {
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
  } else {
    return Positioned(
      right: context.heightPct(2),
      child: Image.asset(
        "assets/images/login_images/logo_burger.png",
        height: context.heightPct(20),
      ),
    );
  }
}
