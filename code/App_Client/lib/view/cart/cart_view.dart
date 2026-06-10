import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/service/cart/add_remove_order.dart';
import 'package:app_pizza_client/service/cart/change_pice.dart';
import 'package:app_pizza_client/view/home/b_N_Bar_home.dart';
import 'package:app_pizza_client/widget/appbare_widget/sliverAppBar_widget.dart';
import 'package:app_pizza_client/view/cart/widget/widget_bottomNavigationBar.dart';
import 'package:app_pizza_client/view/cart/widget/widget_cart.dart';
import 'package:flutter/material.dart';

class Order_Page extends StatefulWidget {
  const Order_Page({super.key});

  @override
  State<Order_Page> createState() => _Order_PageState();
}

class _Order_PageState extends State<Order_Page> {
  int calculateTotalOrder() {
  int total = 0;
  for (var item in Cart_Data.cart_of_Products) {
    total += (item.price * item.quqntity);
  }
  return total;
}
  int cartCount = 1;
  final int price_of_order = 450;

  @override
  Widget build(BuildContext context) {
    final Products = Products_Data.cards_of_Products;

    final VoidCallback onAdd;
    final VoidCallback onRemove;
    final int quantity;

    return Scaffold(
      bottomNavigationBar: widget_BottomNavigationBar(context, priceTotal:calculateTotalOrder() ),

      body: CustomScrollView(
        slivers: [
          //
          widget_SliverAppBar(
            context,
            onPressed: () {
              Navigator.of(context).pop();
            },
            title: "Cart Details",
          ),

          SliverPadding(
            padding: EdgeInsets.only(top: context.heightPct(5)),
            sliver: SliverList.builder(
              itemCount: Cart_Data.cart_of_Products.length,
              itemBuilder: (BuildContext context, int index) {
                final item = Cart_Data.cart_of_Products[index];
                return ListTile(
                  minVerticalPadding: context.heightPct(1.5),
                  title: widget_Card_Cart(
                    context,
                    onAdd: () {
                      setState(() {
                        item.quqntity++;
                      });
                    },
                    onRemove: () {
                      setState(() {
                        if (item.quqntity > 1) {
                          item.quqntity--;
                        }
                      });
                    },
                    quantity: item.quqntity,
                    price: item.price * item.quqntity,
                    imagePath: item.imagePath,
                    name: item.name,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
