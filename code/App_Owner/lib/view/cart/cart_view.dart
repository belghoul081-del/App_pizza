import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/client/client_Model.dart';
import 'package:app_pizza_owner/models/model_cart/cart_Model.dart';
import 'package:app_pizza_owner/models/order/order_Model.dart';
import 'package:app_pizza_owner/models/order/state_order_Model.dart';
import 'package:app_pizza_owner/provider/orderp/order_Provider.dart';
import 'package:app_pizza_owner/view/cart/new/state%20bar/stateCard.dart';
import 'package:app_pizza_owner/view/cart/new/general_cart_card.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
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
      // if (selectedIndex == 0) {
      //   return allOrders;
      // } else {
      //   String selectedState = State_Order_Date.state[selectedIndex - 1].state;
      //   return allOrders
      //       .where((order) => order.status.state == selectedState)
      //       .toList();
      // }
      if (selectedIndex == 0) return orders;
      String targetState = State_Order_Date.state[selectedIndex - 1].state;

      return orders
          .where((order) => order.status.state == targetState)
          .toList();
    }

    return Scaffold(
      appBar: Widget_appBar(context, title: "order Details"),
      body: CustomScrollView(
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

          /// cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final filterList = getFilterOrder(allOrders);
                final currentOrder = filterList[index];
                return cardOrder(context, order: currentOrder);
              },
              childCount: getFilterOrder(allOrders).length,
              //allOrders.length
            ),
          ),
        ],
      ),
    );
  }
}


/*

    CartProvider cartProvider = Provider.of<CartProvider>(context);


 bottomNavigationBar: widget_BottomNavigationBar(
        context,
        priceTotal: cartProvider.total_Price_Cart(),
      ),

CustomScrollView(
        slivers: [
          //
          Widget_appBar(context, title: "Cart Details"),

          SliverPadding(
            padding: EdgeInsets.only(top: context.heightPct(5)),
            sliver: SliverList.builder(
              itemCount: carts.length,
              itemBuilder: (BuildContext context, int index) {
                final item = carts[index];

                return ListTile(
                  minVerticalPadding: context.heightPct(1.5),
                  title: item.sepliment.isEmpty
                      ? widget_Card_Cart(
                          context,
                          onAdd: () {
                            cartProvider.addQuantity(item);
                          },
                          onRemove: () {
                            cartProvider.removeQuantity(item);
                          },
                          quantity: item.quantity,
                          price: item.product.price * item.quantity,
                          imagePath: item.product.imagePath,
                          name: item.product.name,
                          sepliment: List.empty(),
                          delete_press: () {
                            cartProvider.removeFromCart(item);
                          },
                        )
                      : widget_Card_Cart(
                          context,
                          onAdd: () {
                            cartProvider.addQuantity(item);
                          },
                          onRemove: () {
                            cartProvider.removeQuantity(item);
                          },
                          quantity: item.quantity,

                          price: item.pricePerUnit * item.quantity,

                          imagePath: item.product.imagePath,
                          name: item.product.name,
                          sepliment: item.sepliment,
                          delete_press: () {
                            cartProvider.removeFromCart(item);
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
 */