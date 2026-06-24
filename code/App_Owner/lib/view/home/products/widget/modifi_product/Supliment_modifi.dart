import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/widget_textModefi.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/widget_textmodefi_product.dart';
import 'package:app_pizza_owner/widget/custom/costum_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';

class Sepliment_Widget extends StatefulWidget {
  final Products_model product;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Sepliment_Widget({
    super.key,
    required this.product,
    required this.scaffoldKey,
  });

  @override
  State<Sepliment_Widget> createState() => _Sepliment_WidgetState();
}

class _Sepliment_WidgetState extends State<Sepliment_Widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.heightPct(2),
        vertical: context.heightPct(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// text :
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Supliment",
                  style: TextStyle(
                    fontSize: context.heightPct(3),
                    fontFamily: "InterBold",
                    color: ColorApp_Text.textbrown,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: context.heightPct(4),
            width: context.heightPct(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorApp_Icon_border.bottonbrown),
              color: ColorApp_Background.appbarecolor,
            ),

            child: IconButton(
              onPressed: () {
                TextEditingController priceController = TextEditingController(
                  text: widget.product.price.toString(),
                );

                widget.scaffoldKey.currentState!.showBottomSheet(
                  (context) => Container(
                    height: context.heightPct(80), // ستغطي 80% من الشاشة
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorApp_Background.appbarecolor,
                      border: Border.all(
                        color: ColorApp_Icon_border.bottonbrown,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.all(20),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: widget.product.supplements.length,
                            itemBuilder: (context, index) {
                              final item = widget.product.supplements[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.heightPct(2),
                                  vertical: 4, // مسافة صغيرة بين العناصر
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "• ${item.name}",
                                      style: TextStyle(
                                        fontSize: context.heightPct(2.5),
                                        fontFamily: "InterBold",
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${item.price}Da",
                                      style: TextStyle(
                                        fontSize: context.heightPct(2.5),
                                        fontFamily: "InterBold",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 20),
                          Widget_botton(
                            context,
                            text: 'save',
                            onPressed: () {
                              setState(() {
                                widget.product.price =
                                    int.tryParse(priceController.text) ?? 0;
                              });
                              Navigator.pop(context);
                            },
                            height: 7,
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  enableDrag: true,
                );
              },
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: context.heightPct(3),
                color: ColorApp_Icon_border.bottonbrown,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
