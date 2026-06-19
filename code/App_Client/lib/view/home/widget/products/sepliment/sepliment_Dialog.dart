import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_client/provider/cart/sepliment_Provider.dart';
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
    ), // تصغير الهوامش الجانبية
    child: Container(
      padding: EdgeInsets.all(context.heightPct(2)),
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown, width: 2),
      ),
      child: Consumer<SeplimentProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize:
                MainAxisSize.min, // سيجعل الدايلوج يأخذ حجم المحتوى فقط
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
                itemCount: Sepliment_Data.sepliment.length,
                itemBuilder: (context, index) {
                  final item = Sepliment_Data.sepliment[index];
                  return SizedBox(
                    height: context.heightPct(5), // تصغير ارتفاع كل صف
                    child: ButttonOfSepliment(
                      name: item.name,
                      price: item.price,
                      onchange: (val) =>
                          provider.selectSepliment(item, val ?? false),
                    ),
                  );
                },
              ),

              const Divider(), // فاصل جمالي
              // الجزء السفلي (السعر والزر)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${provider.CalculatePrice(product.price)} Da",
                    style: TextStyle(
                      fontSize: context.heightPct(2),
                      color: ColorApp_Botton.bottonOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  MaterialButton(
                    onPressed: () => Navigator.pop(context), // إغلاق الدايلوج
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

class ButttonOfSepliment extends StatefulWidget {
  final String name;
  final int price;
  final Function(bool?) onchange; // تأكد من مطابقة هذا النوع
  const ButttonOfSepliment({
    super.key,
    required this.name,
    required this.price,
    required this.onchange,
  });

  @override
  State<ButttonOfSepliment> createState() => _ButttonOfSeplimentState();
}

class _ButttonOfSeplimentState extends State<ButttonOfSepliment> {
  bool isChecked = false; // حالة الاختيار هنا
  final currentSupplement = Sepliment_model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.name} (${widget.price} Da)",
          style: TextStyle(
            fontSize: context.heightPct(2),
            fontWeight: FontWeight.bold,
          ),
        ),
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onchange(value);
          },
        ),
      ],
    );
  }
}
