import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/provider/admin/admin_provider.dart';
import 'package:app_pizza_client/widget/custom/sosssw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

AppBar Widget_appBar_chat(BuildContext context) {
  return AppBar(
    backgroundColor: ColorApp_Background.backgroundcolor,

    /// icon
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: ColorApp_Icon_border.bottonbrown,
      ),
      iconSize: context.heightPct(6),

      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    toolbarHeight: context.heightPct(10),
    title: Padding(
      padding: EdgeInsets.only(left: context.heightPct(9)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "chat",
              style: TextStyle(
                fontSize: context.heightPct(5),
                fontFamily: "InriaSerif",
                color: ColorApp_Icon_border.bottonbrown,
              ),
            ),
            SizedBox(width: context.widthPct(3)),
            IconButton(
              icon: Icon(Icons.call, color: ColorApp_Botton.bottonOrange),
              iconSize: context.heightPct(5),

              onPressed: () => _showCallOptionsSheet(context),
            ),
            IconButton(
              icon: Icon(
                Icons.headset_mic_outlined,
                color: ColorApp_Botton.bottonOrange,
              ),
              iconSize: context.heightPct(5),

              onPressed: () => showFeatureUnavailableBottomSheet(context),
            ),
          ],
        ),
      ),
    ),

    /// line
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        color: ColorApp_Icon_border.bottonbrown,
        height: context.heightPct(0.3),
      ),
    ),
  );
}

void _showCallOptionsSheet(BuildContext context) {
  final adminProvider = Provider.of<AdminProvider>(context, listen: false);
  final admin = adminProvider.admin;

  // قائمة الأرقام المتاحة فقط (تجاهل أي رقم فارغ)
  final List<MapEntry<String, String>> numbers = [
    if (admin.number.trim().isNotEmpty) MapEntry("Number One", admin.number),
    if (admin.number2.trim().isNotEmpty) MapEntry("Number Two", admin.number2),
  ];

  if (numbers.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No contact number is currently available')),
    );
    return;
  }

  // إن كان هناك رقم واحد فقط متاح، اتصل به مباشرة دون عرض قائمة
  if (numbers.length == 1) {
    _callNumber(context, numbers.first.value);
    return;
  }

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      return Container(
        width: context.widthPct(90),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          left: context.widthPct(5),
          right: context.widthPct(5),
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
            Container(
              width: context.widthPct(15),
              height: context.heightPct(0.7),
              decoration: BoxDecoration(
                color: ColorApp_Icon_border.bottonbrown.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: context.heightPct(2)),
            Text(
              "Choose a contact number",
              style: TextStyle(
                fontSize: context.heightPct(2.4),
                fontFamily: "InterBold",
                color: ColorApp_Text.textbrown,
              ),
            ),
            SizedBox(height: context.heightPct(2)),
            for (final entry in numbers)
              Padding(
                padding: EdgeInsets.only(bottom: context.heightPct(1.2)),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _callNumber(context, entry.value);
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      height: context.heightPct(7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE6C8),
                        border: Border.all(
                          color: ColorApp_Icon_border.bottonbrown,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.call, color: ColorApp_Botton.bottonOrange),
                          SizedBox(width: context.widthPct(2)),
                          Text(
                            "${entry.key} - ${entry.value}",
                            style: TextStyle(
                              color: ColorApp_Text.textbrown,
                              fontSize: context.heightPct(2),
                              fontFamily: "InterBold",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: context.heightPct(1)),
          ],
        ),
      );
    },
  );
}

Future<void> _callNumber(BuildContext context, String phoneNumber) async {
  final uri = Uri.parse('tel:$phoneNumber');
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open the phone application')),
        );
      }
    }
  } catch (e) {
    debugPrint('Connection error: $e');
  }
}
