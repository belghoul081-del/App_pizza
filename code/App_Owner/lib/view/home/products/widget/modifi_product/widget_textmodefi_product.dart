import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget Text_Modefie_Product({
  required BuildContext context,
  required int? maxLength,
  required int hintText, //text in side
  required IconData icon, //icon
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text, // type of text
  Function(String)? onChanged,
  String? Function(String?)? validator,
}) {
  return Container(
    height: context.heightPct(5.5),
    width: context.widthPct(90),
    decoration: BoxDecoration(
      color: ColorApp_Background.spaceofwrite_info_massege,
      border: Border.all(
        color: const Color(0xFF472900),
        width: context.heightPct(0.15),
      ),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.widthPct(2),
            right: context.widthPct(3),
          ),
          child: Container(
            child:Icon(
                    icon,
                    size: context.heightPct(5),
                    color: ColorApp_Icon_border.bottonbrown,
                  )
                
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            maxLength: maxLength,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            initialValue: controller=null,
            decoration: InputDecoration(
              counterText: "",
              hintStyle: TextStyle(
                color: Colors.black38,
                fontSize: context.heightPct(2),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: context.heightPct(0.5)),
            ),
          ),
        ),
      ],
    ),
  );
}
