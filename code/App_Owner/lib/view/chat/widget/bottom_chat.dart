import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Bottom_chat(BuildContext context, {required Future<void> Function(String) onSend}) {
  final TextEditingController controller = TextEditingController();

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.widthPct(5),
      vertical: context.heightPct(1),
    ),
    child: Container(
      height: context.heightPct(7),
      width: context.widthPct(80),
      decoration: BoxDecoration(
        color: ColorApp_Background.spaceofwrite_info_massege,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(4)),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Messege ...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final text = controller.text;
              controller.clear();
              await onSend(text);
            },
            icon: Icon(
              Icons.send,
              color: ColorApp_Icon_border.bottonbrown,
              size: context.heightPct(5),
            ),
          ),
        ],
      ),
    ),
  );
}
