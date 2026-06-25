import 'dart:io';

import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/service/service_PhotoProduct.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/Supliment_modifi.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/widget_IconImage.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/widget_textModefi.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/widget_textmodefi_product.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
import 'package:app_pizza_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Modifi_Product_Page extends StatefulWidget {
  final Products_model product;
  const Modifi_Product_Page({super.key, required this.product});

  @override
  State<Modifi_Product_Page> createState() => _Modifi_Product_PageState();
}

class _Modifi_Product_PageState extends State<Modifi_Product_Page> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  File? _selectedImage; 
  final ImagePickerService _imageService = ImagePickerService();

  Future<void> _pickImage() async {
    File? image = await _imageService.pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        // هنا يمكنك إضافة منطق تحديث مسار الصورة في الموديل الخاص بك لاحقاً
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Widget_appBar(context, title: "product details"),
      body: Center(
        child: Column(
          children: [
           Image_modifi(
              context, 
              image: widget.product.imagePath, 
              selectedImage: _selectedImage, // نمرر الصورة المختارة
              onPressed: _pickImage, // نمرر الدالة مباشرة
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.heightPct(2)),
              child: DashedLineDivider(
                height: 3,
                dashWidth: 3,
                dashSpace: 0,
                color: ColorApp_Icon_border.bottonbrown,
              ),
            ),
            //name
            Text_show_Product(
              context: context,
              title: "Name : ",
              item: widget.product.name,
              onPressed: () {
                TextEditingController nameController = TextEditingController(
                  text: widget.product.name,
                );

                scaffoldKey.currentState!.showBottomSheet(
                  (context) => Container(
                    height: context.heightPct(20),
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
                    child: Column(
                      children: [
                        Text_Modefie_Product(
                          context: context,
                          controller: nameController,
                          hintText: 'enter new name',
                        ),
                        SizedBox(height: 20),
                        Widget_botton(
                          context,
                          text: 'save',
                          onPressed: () {
                            setState(() {
                              widget.product.name = nameController.text;
                            });
                            Navigator.pop(context);
                          },
                          height: 7,
                          width: 30,
                           backgroundColor: ColorApp_Botton.bottonOrange,
                          textColor: ColorApp_Icon_border.bottonbrown
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //price
            Text_show_Product(
              context: context,
              title: "Price : ",
              item: "${widget.product.price} Da",
              onPressed: () {
                TextEditingController priceController = TextEditingController(
                  text: widget.product.price.toString(),
                );

                scaffoldKey.currentState!.showBottomSheet(
                  (context) => Container(
                    height: context.heightPct(20),
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
                    child: Column(
                      children: [
                        Text_Modefie_Product(
                          context: context,
                          controller: priceController,
                          hintText: 'enter new price',
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
                          backgroundColor: ColorApp_Botton.bottonOrange,
                          textColor: ColorApp_Icon_border.bottonbrown
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //supliment
            Sepliment_Widget(product: widget.product, scaffoldKey: scaffoldKey),
          ],
        ),
      ),
    );
  }
}
