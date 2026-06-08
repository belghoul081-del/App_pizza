import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/view/home/widget/products/botton_Cards.dart';
import 'package:app_pizza_client/view/home/widget/products/faverit_icon.dart';
import 'package:app_pizza_client/view/home/widget/products/image_cards.dart';
import 'package:app_pizza_client/view/home/widget/products/text_cards.dart';
import 'package:flutter/material.dart';

class Widget_Cards_product extends StatefulWidget {
  final Products_model product;
  const Widget_Cards_product({super.key, required this.product});

  @override
  State<Widget_Cards_product> createState() => _Widget_Cards_productState();
}

class _Widget_Cards_productState extends State<Widget_Cards_product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3,
            offset: Offset(0, 0),
            spreadRadius: 1,
          ).scale(1.5),
        ],
      ),
      child: Stack(
        children: [
          Widget_Faverit_Icon(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Widget_Images_Cards(context, image: widget.product.imagePath),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.heightPct(0.6),
                  ),
                  child: widget_Title_Cards(context, text: widget.product.name),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.widthPct(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      widget_Price_Cards(context, widget.product.price),
                      Row(
                        children: [
                          widget_Botton_Cards(
                            context,
                            color: ColorApp_Background.backgroundcolorII,
                            icon: Icons.list,
                          ),
                          SizedBox(width: context.widthPct(1)),
                          widget_Botton_Cards(
                            context,
                            color: ColorApp_Botton.bottonOrange,
                            icon: 
                              Icons.add,
                            
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
