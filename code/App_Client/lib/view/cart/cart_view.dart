import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget_BottomNavigationBar(context),

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
          SliverList.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("data"));
            },
          ),
        ],
      ),
    );
  }
}

/*
  Container(
            height: 12,
            width: double.infinity,
            color: Colors.amberAccent,
          ),

 */
