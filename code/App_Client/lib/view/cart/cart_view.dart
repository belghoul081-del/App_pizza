import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_client/provider/cart/cart_Provider.dart';
import 'package:app_pizza_client/widget/appbare_widget/sliverAppBar_widget.dart';
import 'package:app_pizza_client/view/cart/widget/widget_bottomNavigationBar.dart';
import 'package:app_pizza_client/view/cart/widget/widget_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order_Page extends StatefulWidget {
  const Order_Page({super.key});

  @override
  State<Order_Page> createState() => _Order_PageState();
}

class _Order_PageState extends State<Order_Page> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<Cart_model> carts = cartProvider.carts.reversed.toList();

    return Scaffold(
      bottomNavigationBar: widget_BottomNavigationBar(
        context,
        priceTotal: cartProvider.total_Price_Cart(),
      ),

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
              itemCount: carts.length,
              itemBuilder: (BuildContext context, int index) {
                final item = carts[index];
              
                return ListTile(
                  minVerticalPadding: context.heightPct(1.5),
                  title: item.sepliment.isEmpty?
                  
                   widget_Card_Cart(
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
                    price: item.product.price * item.quantity,
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
    );
  }
}
