import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/service/service_supplements.dart';
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
          Text(
            "Supliment",
            style: TextStyle(
              fontSize: context.heightPct(3),
              fontFamily: "InterBold",
              color: ColorApp_Text.textbrown,
            ),
          ),
          Row(
            children: [
              Container(
                height: context.heightPct(4),
                width: context.heightPct(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  color: ColorApp_Background.appbarecolor,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    TextEditingController newNameController =
                        TextEditingController();
                    TextEditingController newPriceController =
                        TextEditingController();

                    // متغير لتخزين الحالة (false للعام، true للخاص)
                    bool isSpecific = true;

                    widget.scaffoldKey.currentState!.showBottomSheet(
                      (context) => StatefulBuilder(
                        // استخدام StatefulBuilder لتحديث الأزرار داخل الـ BottomSheet
                        builder: (context, setBottomSheetState) => Container(
                          height: context.heightPct(
                            40,
                          ), // زدنا الارتفاع قليلاً لاستيعاب الأزرار
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: ColorApp_Background.appbarecolor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              // زر اختيار النوع
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => setBottomSheetState(
                                        () => isSpecific = true,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isSpecific
                                              ? ColorApp_Icon_border.bottonbrown
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: ColorApp_Icon_border
                                                .bottonbrown,
                                          ),
                                        ),
                                        child: Text(
                                          "Specific",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => setBottomSheetState(
                                        () => isSpecific = false,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: !isSpecific
                                              ? ColorApp_Icon_border.bottonbrown
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: ColorApp_Icon_border
                                                .bottonbrown,
                                          ),
                                        ),
                                        child: Text(
                                          "Global",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: context.heightPct(2)),

                              // باقي الحقول (Name & Price)
                              Text_Modefie_Product(
                                context: context,
                                controller: newNameController,
                                hintText: 'Enter name',
                              ),
                              SizedBox(height: context.heightPct(2)),
                              Text_Modefie_Product(
                                context: context,
                                controller: newPriceController,
                                hintText: 'Enter price',
                              ),

                              SizedBox(height: context.heightPct(2)),
                              Widget_botton(
                                context,
                                text: 'Add',
                                onPressed: () {
                                  if (newNameController.text.isNotEmpty &&
                                      newPriceController.text.isNotEmpty) {
                                    setState(() {
                                      SupplementService.addSupplement(
                                        name: newNameController.text,
                                        price:
                                            int.tryParse(
                                              newPriceController.text,
                                            ) ??
                                            0,
                                        isSpecific: isSpecific,
                                        categories: widget.product.categories,
                                      );
                                    });
                                    Navigator.pop(context);
                                  }
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
                    Icons.add,
                    size: context.heightPct(3),
                    color: ColorApp_Icon_border.bottonbrown,
                  ),
                ),
              ),

              SizedBox(width: context.heightPct(1)),
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
                    widget.scaffoldKey.currentState!.showBottomSheet(
                      (context) => Container(
                        height: context.heightPct(80),
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
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
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Supliment",
                                style: TextStyle(
                                  fontSize: context.heightPct(4),
                                  fontFamily: "InterBold",
                                  color: ColorApp_Text.textbrown,
                                ),
                              ),
                              SizedBox(height: context.heightPct(5)),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final category = widget.product.categories;
                                    final specific =
                                        SupplementService.getOnlySupplements(
                                          category,
                                        );
                                    final global =
                                        SupplementService.getAllSupplements(
                                          category,
                                        );
                                    List<dynamic> displayList = [];
                                    if (specific.isNotEmpty) {
                                      displayList.add("Specially:");
                                      displayList.addAll(specific);
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

                                        // التحقق: هل هو عنوان (String) أم إضافة (Supplement_model)؟
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
                                                color: Color.fromARGB(
                                                  255,
                                                  218,
                                                  127,
                                                  0,
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        // هنا تضع التصميم الخاص بعرض الإضافة (item.name, item.price)
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            left: context.heightPct(2),
                                            top: context.heightPct(2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "- ${item.name}",
                                                style: TextStyle(
                                                  fontSize: context.heightPct(
                                                    2.5,
                                                  ),
                                                  fontFamily: "InterBold",
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${item.price}Da",
                                                    style: TextStyle(
                                                      fontSize: context
                                                          .heightPct(2.5),
                                                      fontFamily: "InterBold",
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: context.heightPct(1),
                                                  ),
                                                  Container(
                                                    height: context.heightPct(
                                                      4,
                                                    ),
                                                    width: context.heightPct(4),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            ColorApp_Icon_border
                                                                .bottonbrown,
                                                      ),
                                                      color: ColorApp_Background
                                                          .backgroundcolorII,
                                                    ),

                                                    child: IconButton(
                                                      onPressed: () {
                                                        TextEditingController
                                                        suplimentController =
                                                            TextEditingController(
                                                              text: item.name,
                                                            );
                                                        TextEditingController
                                                        suplimentPriceController =
                                                            TextEditingController(
                                                              text: item.price
                                                                  .toString(),
                                                            );

                                                        widget.scaffoldKey.currentState!.showBottomSheet(
                                                          (
                                                            context,
                                                          ) => Container(
                                                            height: context
                                                                .heightPct(30),
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: ColorApp_Background
                                                                  .appbarecolor,
                                                              border: Border.all(
                                                                color: ColorApp_Icon_border
                                                                    .bottonbrown,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          30,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          30,
                                                                        ),
                                                                  ),
                                                            ),
                                                            padding:
                                                                EdgeInsets.all(
                                                                  20,
                                                                ),
                                                            child: Column(
                                                              children: [
                                                                Text_Modefie_Product(
                                                                  context:
                                                                      context,
                                                                  controller:
                                                                      suplimentController,
                                                                  hintText:
                                                                      'enter new supliment',
                                                                ),
                                                                SizedBox(
                                                                  height: context
                                                                      .heightPct(
                                                                        2,
                                                                      ),
                                                                ),

                                                                Text_Modefie_Product(
                                                                  context:
                                                                      context,
                                                                  controller:
                                                                      suplimentPriceController,
                                                                  hintText:
                                                                      'enter new supliment',
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),

                                                                Widget_botton(
                                                                  context,
                                                                  text: 'save',
                                                                  onPressed: () {
                                                                    if (suplimentController
                                                                            .text
                                                                            .isNotEmpty &&
                                                                        suplimentPriceController
                                                                            .text
                                                                            .isNotEmpty) {
                                                                      setState(() {
                                                                        item.name =
                                                                            suplimentController.text;
                                                                        item.price =
                                                                            int.tryParse(
                                                                              suplimentPriceController.text,
                                                                            ) ??
                                                                            0;
                                                                      });
                                                                    }

                                                                    Navigator.pop(
                                                                      context,
                                                                    );
                                                                  },
                                                                  height: 7,
                                                                  width: 30,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: context.heightPct(
                                                          3,
                                                        ),
                                                        color:
                                                            ColorApp_Icon_border
                                                                .bottonbrown,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
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
        ],
      ),
    );
  }
}
