import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/view/chat/widget/jf.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget Bottom_chat(
  BuildContext context, {
  required TextEditingController controller,
  required Future<void> Function(String) onSend,
  required Future<void> Function(ImageSource) onSendImage,
  bool isSendingImage = false,
}) {
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
          isSendingImage
              ? Padding(
                  padding: EdgeInsets.all(context.heightPct(1.2)),
                  child: SizedBox(
                    width: context.heightPct(3),
                    height: context.heightPct(3),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  onPressed: () => showImageSourceSheetStyled(
                    context,
                    onSendImage: onSendImage,
                  ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: ColorApp_Icon_border.bottonbrown,
                    size: context.heightPct(5),
                  ),
                ),

          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Messege ...",
                border: InputBorder.none,
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
