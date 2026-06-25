import 'dart:io';

import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/service/service_PhotoProduct.dart';
import 'package:app_pizza_owner/view/home/products/widget/modifi_product/modifi_product_view.dart';
import 'package:app_pizza_owner/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';

Widget Image_modifi(
  BuildContext context, {
  required String image,
  required VoidCallback onPressed,
  File? selectedImage,
}) {
  double sizeBB = context.heightPct(5);
  return Padding(
    padding: EdgeInsets.only(top: context.heightPct(1)),
    child: Stack(
      children: [
        selectedImage != null
            ? Container(
                height: context.heightPct(25),
                decoration: BoxDecoration(
                  color: ColorApp_Icon_border.bottonbrown,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image.file(selectedImage, fit: BoxFit.cover),
                ),
              )
            : Widget_Images_Cards(context, image: image, size: 25),
        Positioned(
          right: 5,
          bottom: 5,
          child: Container(
            height: sizeBB,
            width: sizeBB,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorApp_Botton.bottonOrange),
              color: ColorApp_Background.backgroundcolorII,
            ),

            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.image,
                size: context.heightPct(3.5),
                color: ColorApp_Icon_border.bottonbrown,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget settingButton_Modifi(
  BuildContext context, {
  required Products_model product,
}) {
  return Positioned(
    right: context.heightPct(1.5),
    top: context.heightPct(1.5),
    child: Container(
      height: context.heightPct(6),
      width: context.heightPct(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
        color: ColorApp_Botton.bottonOrange,
      ),

      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Modifi_Product_Page(product: product),
            ),
          );
        },
        icon: Icon(
          Icons.settings,
          size: context.heightPct(5),
          color: ColorApp_Icon_border.bottonbrown,
        ),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
      ),
    ),
  );
}
