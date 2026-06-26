import 'dart:io';

import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/service/service_PhotoProduct.dart';
import 'package:app_pizza_owner/view/products/modifi_product/Supliment_modifi.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_IconImage.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_textmodefi_product.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costom_showBottomSheet.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
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

  Future<void> _pickImage(ImageSource choise) async {
    File? image = await _imageService.pickImage(choise);
    if (image != null) {
      setState(() {
        _selectedImage = image;
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
              item: widget.product.name,
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
                        widget.product.name = nameController.text;
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
              item: "${widget.product.price} Da",
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
                        widget.product.price =
                            int.tryParse(priceController.text) ?? 0;
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
          ],
        ),
      ),
    );
  }
}
