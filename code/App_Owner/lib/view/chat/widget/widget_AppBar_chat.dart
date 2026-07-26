import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/blacklist/blacklist_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

AppBar Widget_appBar_chat(
  BuildContext context, {
  required String title,
  required String number,
  required String clientUID,
  required String clientImage,
}) {
  return AppBar(
    backgroundColor: ColorApp_Background.backgroundcolor,
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
            Expanded(
              child: Text(
                "chat",
                style: TextStyle(
                  fontSize: context.heightPct(3.8),
                  fontFamily: "InriaSerif",
                  color: ColorApp_Icon_border.bottonbrown,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.call, color: ColorApp_Botton.bottonOrange),
              iconSize: context.heightPct(5),
              onPressed: () async {
                final uri = Uri.parse('tel:$number');
                try {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Unable to open the phone application'),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  debugPrint('Connection error: $e');
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: ColorApp_Botton.bottonOrange),
              iconSize: context.heightPct(5),
              onPressed: () => _showClientInfoSheet(
                context,
                name: title,
                number: number,
                image: clientImage,
                clientUID: clientUID,
              ),
            ),
          ],
        ),
      ),
    ),

    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        color: ColorApp_Icon_border.bottonbrown,
        height: context.heightPct(0.3),
      ),
    ),
  );
}

void _showClientInfoSheet(
  BuildContext context, {
  required String name,
  required String number,
  required String image,
  required String clientUID,
}) {
  final bool isNetwork = image.startsWith('http');

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      return Consumer<BlacklistProvider>(
        builder: (sheetContext, blacklistProvider, child) {
          final bool isBlocked = blacklistProvider.isBlocked(clientUID);

          return Container(
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
                Container(
                  width: context.widthPct(15),
                  height: context.heightPct(0.7),
                  decoration: BoxDecoration(
                    color: ColorApp_Icon_border.bottonbrown.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: context.heightPct(2)),

                CircleAvatar(
                  radius: 45,
                  backgroundImage: isNetwork
                      ? NetworkImage(image) as ImageProvider
                      : AssetImage(image),
                ),
                SizedBox(height: context.heightPct(2)),

                // الاسم
                Text(
                  name,
                  style: TextStyle(
                    fontSize: context.heightPct(2.5),
                    fontFamily: "InterBold",
                    color: ColorApp_Text.textbrown,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.heightPct(1)),

                // الرقم
                Text(
                  number,
                  style: TextStyle(
                    fontSize: context.heightPct(1.8),
                    fontFamily: "Inter",
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.heightPct(3)),

                // زر الحظر / إلغاء الحظر
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () async {
                      if (isBlocked) {
                        await blacklistProvider.unblock(clientUID);
                      } else {
                        await blacklistProvider.block(
                          uID: clientUID,
                          name: name,
                          number: number,
                          image: image,
                        );
                      }
                      if (sheetContext.mounted) Navigator.pop(sheetContext);
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      height: context.heightPct(7),
                      decoration: BoxDecoration(
                        color: isBlocked ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isBlocked ? Icons.check_circle : Icons.block,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              isBlocked ? "Unblock Customer" : "Block Customer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.heightPct(2.2),
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
    },
  );
}
