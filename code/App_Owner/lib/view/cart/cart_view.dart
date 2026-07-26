import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/order/order_Model.dart';
import 'package:app_owner/models/order/state_order_Model.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:app_owner/view/cart/widget/state%20bar/stateCard.dart';
import 'package:app_owner/view/cart/pages/general_cart_card.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order_Page extends StatefulWidget {
  const Order_Page({super.key});

  @override
  State<Order_Page> createState() => _Order_PageState();
}

class _Order_PageState extends State<Order_Page> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final allOrders = orderProvider.allOrders;

    List<Order_Model> getFilterOrder(List<Order_Model> orders) {
      ///ALL
      if (selectedIndex == 0) {
        return orders.where((order) => order.status.state != "Finish").toList();
      }
      ///Oter
      String targetState = State_Order_Date.state[selectedIndex - 1].state;

      return orders
          .where((order) => order.status.state == targetState)
          .toList();
    }

    final filterList = getFilterOrder(allOrders);

    return Scaffold(
      appBar: Widget_appBar(context, title: "order Details"),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                /// لا تتجرك
                SliverAppBar(
                  shadowColor: Colors.black,
                  floating: false,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: context.heightPct(10.2),
                  titleSpacing: 0,
                  pinned: true,
                  backgroundColor: ColorApp_Background.backgroundcolor,
                  surfaceTintColor: ColorApp_Background.backgroundcolor,
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// categories
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.heightPct(1.5),
                          bottom: context.heightPct(1.5),
                        ),
                        child: state_Card(
                          context: context,
                          selectedIndex: selectedIndex,
                          onCategorySelected: (int index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      ),

                      DashedLineDivider(
                        height: context.heightPct(0.2),
                        dashWidth: context.heightPct(3.5),
                        dashSpace: context.heightPct(2),
                        color: ColorApp_Icon_border.bottonbrown,
                      ),
                    ],
                  ),
                ),
                if (filterList.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        orderProvider.error ??
                            "There are no orders at the moment",
                        style: TextStyle(
                          color: ColorApp_Text.textbrown,
                          fontSize: context.heightPct(2),
                        ),
                      ),
                    ),
                  )
                else
                  /// cards
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final currentOrder = filterList[index];
                      return cardOrder(context, order: currentOrder);
                    }, childCount: filterList.length),
                  ),
              ],
            ),
    );
  }
}
