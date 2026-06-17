import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/view/cart/cart_is_empty_view.dart';
import 'package:flutter/material.dart';

NavigationDestination NavigationDestination_bar_home({
  required BuildContext context,
  required int x,
  int? quantity,
}) {
  if (x == 1) {
    return NavigationDestination(icon: Icon(Icons.home_sharp), label: '');
  } else if (x == 2) {
    return NavigationDestination(
      icon: SizedBox(
        height: context.heightPct(10),
        width: context.heightPct(10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -context.heightPct(5),
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: context.heightPct(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  shape: CircleBorder(),
                  onPressed: () {
                    if (quantity == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => empty_Order_Page(),
                        ),
                      );
                    } else {
                      Navigator.of(context).pushNamed("Cart");
                    }
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    color: ColorApp_Background.appbarecolor,
                    size: context.heightPct(7.5),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -context.heightPct(7),
              left: 0,
              right: -context.heightPct(7),
              child: Container(
                alignment: Alignment.center,
                height: context.heightPct(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorApp_Background.appbarecolor,
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                ),
                child: Text(
                  "${quantity}",
                  style: TextStyle(
                    color: ColorApp_Text.textred,
                    fontFamily: "SemiBold",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      label: '',
    );
  } else {
    return NavigationDestination(icon: Icon(Icons.chat_outlined), label: '');
  }
}
