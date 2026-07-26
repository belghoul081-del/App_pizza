import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_owner/provider/cart/cart_Provider.dart';
import 'package:app_owner/provider/cart/sepliment_Provider.dart';
import 'package:app_owner/view/products/widget/sepliment/buttton_of_sepliment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Dialog SeplimentDialog(
  BuildContext context, {
  required Products_model product,
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: EdgeInsets.symmetric(
      horizontal: context.widthPct(5),
    ),
    child: Container(
      padding: EdgeInsets.all(context.heightPct(2)),
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown, width: 2),
      ),
      child: Consumer<SeplimentProvider>(
        builder: (context, provider, child) {
          final allSupplements = Sepliment_Data.general_supplements.where((s) {
            // خاص بالمنتج
            if (s.ProductId == product.id) return true;
            // خاص بالفئة
            if (s.categories == product.categories && s.ProductId == '')
              return true;
            // عام
            if (s.categories == '' && s.ProductId == '') return true;
            return false;
          }).toList();
          return Column(
            mainAxisSize:
                MainAxisSize.min, 
            children: [
              Text(
                "Sepliment",
                style: TextStyle(
                  fontSize: context.heightPct(2.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.heightPct(1)),

              // قائمة الإضافات
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allSupplements.length,
                itemBuilder: (context, index) {
                  final item = allSupplements[index];
                  return SizedBox(
                    height: context.heightPct(5),
                    child: ButttonOfSepliment(
                      name: item.name,
                      price: item.price,
                      onchange: (val) =>
                          provider.selectSepliment(item, val ?? false),
                    ),
                  );
                },
              ),

              const Divider(),
              //   (السعر والزر)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${provider.calculatePrice(product.price)} Da",
                    style: TextStyle(
                      fontSize: context.heightPct(2),
                      color: ColorApp_Botton.bottonOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      final CartProvider cartProvider =
                          Provider.of<CartProvider>(context, listen: false);
                      final SeplimentProvider seplimentProvider =
                          Provider.of<SeplimentProvider>(
                            context,
                            listen: false,
                          );
                      cartProvider.add_Cart(product, seplimentProvider);
                      seplimentProvider.clearSepliment();
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
