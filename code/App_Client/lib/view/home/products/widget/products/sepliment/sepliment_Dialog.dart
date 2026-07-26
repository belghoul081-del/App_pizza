import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/provider/cart/cart_Provider.dart';
import 'package:app_pizza_client/provider/product/suppliment_provider.dart';
import 'package:app_pizza_client/view/home/products/widget/products/sepliment/buttton_of_sepliment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Dialog SeplimentDialog(BuildContext context, {required Products_model product}) {
  final supplements = product.supplements;

  return Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: EdgeInsets.symmetric(horizontal: context.widthPct(5)),
    child: Container(
      padding: EdgeInsets.all(context.heightPct(2)),
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown, width: 2),
      ),
      child: Consumer<SupplementSelectionProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sepliment",
                style: TextStyle(
                  fontSize: context.heightPct(2.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.heightPct(1)),

              if (supplements.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.heightPct(2)),
                  child: Text(
                    "No supplements are available for this product",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: context.heightPct(1.8),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: supplements.length,
                  itemBuilder: (context, index) {
                    final item = supplements[index];
                    return SizedBox(
                      height: context.heightPct(5),
                      child: ButttonOfSepliment(
                        name: item.name,
                        price: item.price,
                        value: provider.isSelected(item.id),
                        onchange: (val) =>
                            provider.selectSepliment(item, val ?? false),
                      ),
                    );
                  },
                ),

              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${provider.calculatePrice(product.price, supplements)} Da",
                    style: TextStyle(
                      fontSize: context.heightPct(2),
                      color: ColorApp_Botton.bottonOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      final cartProvider = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      final selected = provider.getSelectedSupplements(
                        supplements,
                      );
                      cartProvider.add_Cart(product, selected);
                      provider.clearSelection();
                      Navigator.pop(context);
                    },
                    color: ColorApp_Botton.bottonOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: ColorApp_Text.textbrown),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}
