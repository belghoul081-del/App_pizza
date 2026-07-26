import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/order/order_Model.dart';
import 'package:app_owner/provider/event/time.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:app_owner/view/cart/widget/app_bare_order_page.dart';
import 'package:app_owner/view/cart/widget/order_item_card.dart';
import 'package:app_owner/view/cart/widget/showDialog/show_card_dialg.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page_Cart_Order extends StatefulWidget {
  final Order_Model order;
  const Page_Cart_Order({super.key, required this.order});

  @override
  State<Page_Cart_Order> createState() => _Page_Cart_OrderState();
}

class _Page_Cart_OrderState extends State<Page_Cart_Order> {
  bool _isBusy = false;

  Future<void> _accept() async {
    setState(() => _isBusy = true);
    try {
      await Provider.of<OrderProvider>(
        context,
        listen: false,
      ).advanceOrderStatus(widget.order);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Order status update failed: $e')));
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => costumAlertDialog(
        context,
        onPresseddelete: () => Navigator.pop(ctx, true),
        onPressedcancel: () => Navigator.pop(ctx, false),
      ),
    );
    if (confirm != true) return;

    setState(() => _isBusy = true);
    try {
      await Provider.of<OrderProvider>(
        context,
        listen: false,
      ).deleteOrder(widget.order.orderId);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Deletion failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final String dateLabel = order.createdAt != null
        ? Time_Calculate().showFullTime(order.createdAt!)
        : "--";
    String textStates() {
      if (order.status.state == "waiting") {
        return "accepte";
      } else if (order.status.state == "Cook") {
        return "Delivery";
      } else if (order.status.state == "Delivery") {
        return "Finish";
      } else {
        return "";
      }
    }

    return Scaffold(
      appBar: AppBar_Order_Page(
        context,
        order_ID: order.client.uID,
        image: order.status.imagePath,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.heightPct(0.5),
                  horizontal: context.heightPct(2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateLabel,
                      style: TextStyle(
                        fontFamily: "SemiBold",
                        fontSize: context.heightPct(2),
                      ),
                    ),
                    Text(
                      order.status.name,
                      style: TextStyle(
                        fontFamily: "SemiBold",
                        fontSize: context.heightPct(2),
                      ),
                    ),
                  ],
                ),
              ),

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
                        content: order.orderId,
                      ),
                      TEXT_RICH(
                        context,
                        title: "name : ",
                        content: order.client.name,
                      ),
                      if (order.client.number.isNotEmpty)
                        TEXT_RICH(
                          context,
                          title: "phone : ",
                          content: order.client.number,
                        ),
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
                        child: order.items.isEmpty
                            ? Center(
                                child: Text(
                                  "There are no items in this request.",
                                  style: TextStyle(
                                    color: ColorApp_Text.textbrown,
                                    fontFamily: "SemiBold",
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.only(top: 20),
                                itemCount: order.items.length,
                                itemBuilder: (context, index) {
                                  return Widget_Order_Item_Card(
                                    context,
                                    item: order.items[index],
                                  );
                                },
                              ),
                      ),

                      Container(
                        height: context.heightPct(15.5),
                        width: double.infinity,
                        decoration: const BoxDecoration(
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
                                Dialogbotton_Location(
                                  context,
                                  location: order.location,
                                ),
                                Text(
                                  "${order.totalOrderPrice} Da",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (textStates().isNotEmpty) ...[
                                    Widget_botton(
                                      context,
                                      text: textStates(),
                                      onPressed: _isBusy ? () {} : _accept,
                                      height: 6.5,
                                      width: 60,
                                      backgroundColor:
                                          ColorApp_Botton.bottonOrange,
                                      textColor: ColorApp_Text.textbrown,
                                    ),

                                    Custom_icon_Button(
                                      icon: Icons.delete,
                                      onPressed: _isBusy ? () {} : _delete,
                                    ),
                                  ],
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
          if (_isBusy)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
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
      height: context.heightPct(6.5),
      width: context.heightPct(6.5),
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
