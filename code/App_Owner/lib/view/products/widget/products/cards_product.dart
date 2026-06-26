import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/provider/cart/cart_Provider.dart';
import 'package:app_pizza_owner/provider/cart/sepliment_Provider.dart';
import 'package:app_pizza_owner/view/products/widget/products/botton_Cards.dart';
import 'package:app_pizza_owner/view/products/widget/sepliment/sepliment_Dialog.dart';
import 'package:app_pizza_owner/view/products/detail_product/details_product_view.dart';
import 'package:app_pizza_owner/widget/custom/costum_image_cards.dart';
import 'package:app_pizza_owner/view/products/widget/products/text_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Widget_Cards_product extends StatefulWidget {
  final Products_model product;
  final VoidCallback onChanged;
  const Widget_Cards_product({
    super.key,
    required this.product,
    required this.onChanged,
  });

  @override
  State<Widget_Cards_product> createState() => _Widget_Cards_productState();
}

class _Widget_Cards_productState extends State<Widget_Cards_product> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(0.5)),
            child: widget.product.isAvailable
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Widget_Images_Cards(
                        context,
                        image: widget.product.imagePath,
                        size: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.heightPct(0.6),
                        ),
                        child: widget_Title_Cards(
                          context,
                          text: widget.product.name,
                          color: ColorApp_Text.textbrown,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: context.widthPct(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            widget_Price_Cards(context, widget.product.price),

                            widget_Botton_Cards(
                              context,
                              color: ColorApp_Botton.bottonOrange,
                              icon: Icons.settings,
                              onPress: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => details_Product_Page(
                                      product: widget.product,
                                      onChanged: widget.onChanged,
                                    ),
                                  ),
                                );
                                if (result == true) {
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Widget_Images_Cards(
                          context,
                          image: widget.product.imagePath,
                          size: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.heightPct(0.6),
                          ),
                          child: widget_Title_Cards(
                            context,
                            text: widget.product.name,
                            color: ColorApp_Text.textred,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.heightPct(1),
                              ),
                              child: Text(
                                "in not avalibale",
                                style: TextStyle(
                                  color: ColorApp_Text.textred,
                                  fontFamily: "InterBold",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            widget_Botton_Cards(
                              context,
                              color: ColorApp_Botton.bottonOrange,
                              icon: Icons.settings,
                              // بدلاً من مجرد .push()
                              onPress: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => details_Product_Page(
                                      product: widget.product,
                                      onChanged: widget.onChanged,
                                    ),
                                  ),
                                );
                                if (result == true) {
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
