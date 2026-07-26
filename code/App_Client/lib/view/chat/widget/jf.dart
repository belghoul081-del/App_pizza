import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:image_picker/image_picker.dart';

void showImageSourceSheetStyled(
  BuildContext context, {
  required Future<void> Function(ImageSource) onSendImage,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => Container(
      width: context.widthPct(90),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
      ),
      padding: EdgeInsets.all(context.heightPct(2)),
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        border: Border.all(
          color: ColorApp_Icon_border.bottonbrown,
          width: context.heightPct(0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // مقبض السحب
          Container(
            width: context.widthPct(15),
            height: context.heightPct(0.7),
            decoration: BoxDecoration(
              color: ColorApp_Icon_border.bottonbrown.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: context.heightPct(2)),

          // خيار الكاميرا
          _buildImageOption(
            context: sheetContext,
            icon: Icons.camera_alt,
            label: "Take Photo",
            onTap: () {
              Navigator.pop(sheetContext);
              onSendImage(ImageSource.camera);
            },
          ),
          SizedBox(height: context.heightPct(1)),

          // خيار المعرض
          _buildImageOption(
            context: sheetContext,
            icon: Icons.photo_library,
            label: "Pick from Gallery",
            onTap: () {
              Navigator.pop(sheetContext);
              onSendImage(ImageSource.gallery);
            },
          ),
          SizedBox(height: context.heightPct(2)),
        ],
      ),
    ),
  );
}

Widget _buildImageOption({
  required BuildContext context,
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.heightPct(1.5),
          horizontal: context.heightPct(2),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorApp_Botton.bottonOrange,
              size: context.heightPct(3.5),
            ),
            SizedBox(width: context.widthPct(3)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.heightPct(2.2),
                fontFamily: "InterBold",
                color: ColorApp_Text.textbrown,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
