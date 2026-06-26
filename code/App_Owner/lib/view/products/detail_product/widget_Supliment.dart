import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_owner/service/service_supplements.dart';
import 'package:app_pizza_owner/view/products/detail_product/details_product_view.dart';
import 'package:flutter/material.dart';

class Supplements_View extends StatelessWidget {
  const Supplements_View({super.key, required this.widget});

  final details_Product_Page widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heightPct(27),
      child: Builder(
        builder: (context) {
          final category = widget.product.categories;
          final categorySuppliment = Sepliment_Data.general_supplements
              .where((s) => s.categories == category && s.ProductId == '')
              .toList();
          final productSpecific = Sepliment_Data.general_supplements
              .where((s) => s.ProductId == widget.product.id)
              .toList();
          List allSuppliment = [...categorySuppliment, ...productSpecific];
          final global = Sepliment_Data.general_supplements.where(
            (s) => s.categories == '' && s.ProductId == '',
          );
          List<dynamic> displayList = [];

          if (allSuppliment.isNotEmpty) {
            displayList.add("Category Specific:");
            displayList.addAll(allSuppliment);
          }
          if (global.isNotEmpty) {
            displayList.add("Global:");
            displayList.addAll(global);
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: displayList.length,
            itemBuilder: (context, index) {
              final item = displayList[index];
              if (item is String) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: context.heightPct(2),
                    top: context.heightPct(2),
                    bottom: context.heightPct(1),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: context.heightPct(3),
                      fontFamily: "InterBold",
                      color: Color.fromARGB(255, 218, 127, 0),
                    ),
                  ),
                );
              }
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
          );
        },
      ),
    );
  }
}
