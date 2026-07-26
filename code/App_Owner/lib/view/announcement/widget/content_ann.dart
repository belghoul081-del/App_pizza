import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/model_announcement/announcement_Model.dart';
import 'package:app_owner/view/announcement/widget/announceManger.dart';
import 'package:flutter/material.dart';

Widget Content(
  BuildContext context, {
  required List<Announcement_Model> announcements,
  required int totalBar,
  required PageController controller,
}) {
  return PageView.builder(
    controller: controller,
    itemCount: totalBar,
    itemBuilder: (context, index) {
      // 💡 شرط: إذا وصلنا لنهاية القائمة، اعرض بطاقة "إضافة إعلان"
      if (index == announcements.length) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AnnouncementManagerPage(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorApp_Botton.bottonOrange.withAlpha(
                50,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: ColorApp_Icon_border.bottonbrown,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: context.widthPct(12),
                    color: ColorApp_Icon_border.bottonbrown,
                  ),
                  const SizedBox(height: 8),
                  Text(
                   "Add a new ad",
                    style: TextStyle(
                      color: ColorApp_Icon_border.bottonbrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      //  عرض الإعلان الطبيعي القادم من الفايربيس
      final announcement = announcements[index];

      return Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              announcement
                  .imagePath,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                // ويدجت احتياطي في حال فشل تحميل الصورة من السيرفر
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
