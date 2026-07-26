import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:flutter/material.dart';

class Supplements_View extends StatelessWidget {
  final Products_model product;
  const Supplements_View({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final displayList = product.supplements;
    return SizedBox(
      height: context.heightPct(27),
      child: displayList.isEmpty
          ? Center(
              child: Text(
                "No suppliments for this product yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.heightPct(2.3),
                  fontFamily: "InterBold",
                  color: Color.fromARGB(255, 218, 127, 0),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final item = displayList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.heightPct(2),
                    vertical: 4,
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
