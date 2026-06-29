import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/client/client_Model.dart';
import 'package:app_pizza_owner/models/order/order_Model.dart';
import 'package:app_pizza_owner/view/cart/new/app_bare_order_page.dart';
import 'package:app_pizza_owner/view/cart/widget/showDialog/show_card_dialg.dart';
import 'package:app_pizza_owner/widget/custom/costom_MiniIconButton.dart';
import 'package:app_pizza_owner/widget/custom/costum_Button.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';

class Page_Cart_Order extends StatefulWidget {
  final Order_Model order;
  //  final time time;
  // final State state;
  const Page_Cart_Order({super.key, required this.order});

  @override
  State<Page_Cart_Order> createState() => _Page_Cart_OrderState();
}

class _Page_Cart_OrderState extends State<Page_Cart_Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Order_Page(
        context,
        order_ID: widget.order.orderId,
        image: widget.order.status.imagePath,
      ),
      body: Center(
        child: Column(
          children: [
            /// Time :
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.heightPct(0.5),
                horizontal: context.heightPct(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "19:27",
                    style: TextStyle(
                      fontFamily: "SemiBold",
                      fontSize: context.heightPct(2),
                    ),
                  ),
                  Text(
                    "12-05-2026",
                    style: TextStyle(
                      fontFamily: "SemiBold",
                      fontSize: context.heightPct(2),
                    ),
                  ),
                ],
              ),
            ),

            /// Detail :
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.heightPct(0.5),
                horizontal: context.heightPct(4),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TEXT_RICH(
                      context,
                      title: "order : ",
                      content: widget.order.orderId,
                    ),
                    TEXT_RICH(
                      context,
                      title: "name : ",
                      content: widget.order.client.name,
                    ),
                    TEXT_RICH(
                      context,
                      title: "Location : ",
                      content: "Dalas-100-b2",
                    ),
                    TEXT_RICH(context, title: "Price : ", content: "1200 Da"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorApp_Icon_border.bottonbrown,
                    width: context.heightPct(0.2),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                    opacity: context.heightPct(0.07),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text("منتج رقم $index"));
                        },
                      ),
                    ),

                    Container(
                      height: context.heightPct(15.5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Dialogbotton_Location(context),
                              Text(
                                "1200 Da",
                                style: TextStyle(
                                  color: ColorApp_Text.textbrown,
                                  fontFamily: "InterBold",
                                  fontSize: context.heightPct(3),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              top: context.heightPct(0.2),
                              bottom: context.heightPct(1),
                            ),
                            child: DashedLineDivider(
                              height: 2,
                              dashWidth: 20,
                              dashSpace: 5,
                              color: Colors.grey,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.heightPct(2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Widget_botton(
                                  context,
                                  text: "accepte",
                                  onPressed: () {},
                                  height: 7,
                                  width: 60,
                                  backgroundColor: ColorApp_Botton.bottonOrange,
                                  textColor: ColorApp_Text.textbrown,
                                ),
                                Custom_icon_Button(
                                  icon: Icons.delete,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Text TEXT_RICH(
  BuildContext context, {
  required String title,
  required String content,
}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: title,
          style: TextStyle(
            fontSize: context.heightPct(2.5),
            fontFamily: "InterBold",
            color: ColorApp_Text.textblack,
          ),
        ),
        TextSpan(
          text: content,
          style: TextStyle(
            fontSize: context.heightPct(2),
            fontFamily: "SemiBold",
            color: ColorApp_Text.textblack,
          ),
        ),
      ],
    ),
  );
}

class Custom_icon_Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  const Custom_icon_Button({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.heightPct(7),
      width: context.heightPct(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorApp_Text.textred,
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: context.heightPct(7 * 0.75),
          color: iconColor ?? ColorApp_Icon_border.bottonbrown,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
