import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/view/products/modifi_product/widget_textModefi.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';

class Widget_ShowBottomSheet extends StatelessWidget {
  final double height; //20
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onpressed;
  final TextInputType keyboardType;
  const Widget_ShowBottomSheet({
    super.key,
    required this.height,
    required this.controller,
    required this.onpressed,
    this.keyboardType = TextInputType.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.heightPct(height),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
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
            controller: controller,
            hintText: hintText,
          ),
          SizedBox(height: 20),
          Widget_botton(
            context,
            text: 'save',
            onPressed: onpressed,
            height: 7,
            width: 30,
            backgroundColor: ColorApp_Botton.bottonOrange,
            textColor: ColorApp_Icon_border.bottonbrown,
          ),
        ],
      ),
    );
  }
}
