import 'dart:io';

import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/provider/product/product_Provider.dart';
import 'package:app_pizza_owner/service/service_PhotoProduct.dart';
import 'package:app_pizza_owner/view/products/modifi_product/Supliment_modifi.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_IconImage.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_textmodefi_product.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costom_showBottomSheet.dart';
import 'package:app_pizza_owner/widget/custom/costum_Button.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  Future<void> _pickImage(ImageSource choise) async {
    File? image = await _imageService.pickImage(choise);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  late Products_model tempProduct;
  @override
  void initState() {
    super.initState();
    tempProduct = widget.product.copy();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.product.name;
    int price = widget.product.price;
    return Scaffold(
      key: scaffoldKey,
      appBar: Widget_appBar(context, title: "product details"),
      body: Center(
        child: Column(
          children: [
            Image_modifi(
              context,
              image: widget.product.imagePath,
              selectedImage: _selectedImage,
              scaffoldKey: scaffoldKey,
              onPressedGallery: () {
                _pickImage(ImageSource.gallery);
              },
              onPressedCamera: () {
                _pickImage(ImageSource.camera);
              },
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
              item: tempProduct.name,
              onPressed: () {
                TextEditingController nameController = TextEditingController(
                  text: widget.product.name,
                );

                scaffoldKey.currentState!.showBottomSheet(
                  (context) => Widget_ShowBottomSheet(
                    height: 20,
                    controller: nameController,
                    onpressed: () {
                      setState(() {
                        tempProduct.name = nameController.text;
                      });
                      Navigator.pop(context);
                    },

                    hintText: "enetr new name",
                  ),
                );
              },
            ),
            //price
            Text_show_Product(
              context: context,
              title: "Price : ",
              item: "${tempProduct.price} Da",
              onPressed: () {
                TextEditingController priceController = TextEditingController(
                  text: widget.product.price.toString(),
                );

                scaffoldKey.currentState!.showBottomSheet(
                  (context) => Widget_ShowBottomSheet(
                    height: 20,
                    controller: priceController,

                    onpressed: () {
                      setState(() {
                        // تعديل النسخة المؤقتة وليس الأصلية
                        tempProduct.price = int.parse(priceController.text);
                      });
                      Navigator.pop(context);
                    },
                    hintText: "enter new price",
                  ),
                );
              },
            ),
            //supliment
            Sepliment_Widget(product: widget.product, scaffoldKey: scaffoldKey),
            SizedBox(height: context.heightPct(27)),

            /// delete / add
            Row(
              children: [
                Expanded(
                  child: Widget_botton(
                    context,
                    text: "Delete",
                    onPressed: () {
                      Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      ).removeProduct(widget.product.id);
                      print("delete=====");
                      Navigator.of(context).pushReplacementNamed("Home");
                    },
                    height: 7,
                    width: 40,
                    backgroundColor: const Color.fromARGB(255, 198, 40, 40),
                    textColor: ColorApp_Text.textbrown,
                  ),
                ),
                SizedBox(width: context.heightPct(1)),
                Expanded(
                  child: Widget_botton(
                    context,
                    text: "Add",
                    onPressed: () {
                      if (name == "" || price <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('please enter corruct Name or Price'),
                          ),
                        );
                        return;
                      }
                      // هنا فقط نقوم بتحديث المنتج الأصلي
                      setState(() {
                        widget.product.name = tempProduct.name;
                        widget.product.price = tempProduct.price;
                        if (_selectedImage != null) {
                          // widget.product.imagePath = _selectedImage!.path;
                        }
                      });

                      Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      ).notifyListeners();
                      Navigator.pop(context); // الخروج بعد التأكيد فقط
                    },

                    height: 7,
                    width: 40,
                    backgroundColor: ColorApp_Botton.bottonOrange,
                    textColor: ColorApp_Text.textbrown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
