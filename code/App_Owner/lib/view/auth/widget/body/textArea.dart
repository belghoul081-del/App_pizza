import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter_svg/svg.dart';

Widget text_Area({
  required int chose,
  required BuildContext context,
  required int? maxLength,
  required String label,
  required String hintText, //text in side
  required IconData icon, //icon
  required bool isPassword, //if ******
  TextInputType keyboardType = TextInputType.text, // type of text
  Function(String)? onChanged,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.heightPct(3),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      Container(
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
                child: chose == 0
                    ? Icon(
                        icon,
                        size: context.heightPct(5),
                        color: ColorApp_Icon_border.bottonbrown,
                      )
                    : SvgPicture.asset(
                        'assets/icons/ID_icone.svg',

                        height: context.heightPct(5),
                        colorFilter: const ColorFilter.mode(
                          ColorApp_Icon_border.bottonbrown,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
            ),
            Expanded(
              child: TextFormField(
                maxLength: maxLength,
                validator: validator,
                obscureText: isPassword,
                keyboardType: keyboardType,
                onChanged: onChanged,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: context.heightPct(2),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    bottom: context.heightPct(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
