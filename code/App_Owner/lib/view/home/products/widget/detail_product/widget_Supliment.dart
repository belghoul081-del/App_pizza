import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/view/home/products/widget/detail_product/details_product_view.dart';
import 'package:flutter/material.dart';


class Supplements_View extends StatelessWidget {
  const Supplements_View({
    super.key,
    required this.widget,
  });

  final details_Product_Page widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heightPct(27),
      child: ListView.builder(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
