import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_IconImage.dart';
import 'package:app_pizza_owner/view/products/detail_product/widget_isValid_not.dart';
import 'package:app_pizza_owner/view/products/detail_product/widget_Supliment.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
import 'package:app_pizza_owner/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';

class details_Product_Page extends StatefulWidget {
  final Products_model product;
  final VoidCallback onChanged;

  const details_Product_Page({
    super.key,
    required this.product,
    required this.onChanged,
  });

  @override
  State<details_Product_Page> createState() => _details_Product_PageState();
}

class _details_Product_PageState extends State<details_Product_Page> {
  List<Sepliment_model> supplements = [];
  void initState() {
    super.initState();
    supplements = widget.product.supplements;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_appBar(context, title: "product details"),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.heightPct(2),
            left: context.heightPct(2),
            right: context.heightPct(2),
          ),
          child: Container(
            height: double.infinity,
            width: context.widthPct(90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              border: Border.all(
                color: ColorApp_Icon_border.bottonbrown,
                width: context.heightPct(0.5),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
                opacity: 0.40,
              ),
            ),
            child: Stack(
              children: [
                settingButton_Modifi(context, product: widget.product),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: context.heightPct(1)),
                      child: Widget_Images_Cards(
                        context,
                        image: widget.product.imagePath,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(1),
                      ),
                      child: DashedLineDivider(
                        height: 5,
                        dashWidth: 3,
                        dashSpace: 0,
                        color: ColorApp_Icon_border.bottonbrown,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: context.heightPct(3)),
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: context.heightPct(4),
                          fontFamily: "InriaSerif",
                          color: const Color(0xFF472900),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.heightPct(5),
                        vertical: context.heightPct(1),
                      ),
                      child: Row(
                        children: [
                          Botton_of_avlide_or_not(
                            context,
                            isOpened: widget.product.isAvailable,
                            onChanged: (value) {
                              setState(() {
                                widget.product.isAvailable = value;
                              });
                              widget.onChanged;
                              print("${value}");
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: context.heightPct(3),
                            ),
                            child: widget.product.isAvailable
                                ? Text(
                                    "is Available",
                                    style: TextStyle(
                                      color: ColorApp_Text.textblack,
                                      fontSize: context.heightPct(3),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "is not Available",
                                    style: TextStyle(
                                      color: ColorApp_Text.textred,
                                      fontSize: context.heightPct(3),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.heightPct(3),
                          vertical: context.heightPct(0.5),
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Price : ",
                                style: TextStyle(
                                  fontSize: context.heightPct(4),
                                  fontFamily: "InriaSerif",
                                  color: const Color(0xFF472900),
                                ),
                              ),
                              TextSpan(
                                text: "${widget.product.price} Da",
                                style: TextStyle(
                                  fontSize: context.heightPct(4),
                                  fontFamily: "InriaSerif",
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.heightPct(3),
                        ),
                        child: Text(
                          "Supliment : ",
                          style: TextStyle(
                            fontSize: context.heightPct(4),
                            fontFamily: "InriaSerif",
                            color: const Color(0xFF472900),
                          ),
                        ),
                      ),
                    ),

                    Supplements_View(widget: widget),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
