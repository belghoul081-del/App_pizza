import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/announcement/announce_provider.dart';
import 'package:app_owner/view/announcement/widget/addAnnounce.dart';
import 'package:app_owner/view/cart/widget/showDialog/show_card_dialg.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnnouncementManagerPage extends StatelessWidget {
  const AnnouncementManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnnouncementProvider>();
    final announcements = provider.announcement;

    return Scaffold(
      appBar: Widget_appBar(context, title: "Manage Announcements"),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                //  الإعلانات بشكل عمودي
                Expanded(
                  child: announcements.isEmpty
                      ? const Center(child: Text("No announcements found"))
                      : ListView.builder(
                          padding: EdgeInsets.all(context.heightPct(2)),
                          itemCount: announcements.length,
                          itemBuilder: (context, index) {
                            final ann = announcements[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: context.heightPct(2),
                              ),
                              child: Stack(
                                children: [
                                  // كرت عرض الصورة المرفوعة مسبقاً بالأبعاد الجديدة
                                  Container(
                                    width: double.infinity,
                                    height: context.heightPct(15),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        color: ColorApp_Icon_border.bottonbrown,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Image.network(
                                        ann.imagePath,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey[300],
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                    ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                  // 💡 زر الحذف متموضع في الجانب الأيمن العلوي من الصورة
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () async {
                                          final confirm =
                                              await showDialog<bool>(
                                                context: context,
                                                builder: (context) =>
                                                    _costumAlertDialog(
                                                      context,
                                                      onPressedcancel: () =>
                                                          Navigator.pop(
                                                            context,
                                                            false,
                                                          ),
                                                      onPressedUnblock: () =>
                                                          Navigator.pop(
                                                            context,
                                                            true,
                                                          ),
                                                    ),
                                              );

                                          if (confirm == true) {
                                            await context
                                                .read<AnnouncementProvider>()
                                                .removeAnnouncement(ann.id);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

                // 💡 زر الإضافة الكبير متموضع بشكل ثابت أسفل القائمة كلياً
                Padding(
                  padding: EdgeInsets.all(context.heightPct(2)),
                  child: Widget_botton(
                    context,
                    text: 'Add New Announcement',
                    height: 7,
                    width: 90,
                    backgroundColor: ColorApp_Botton.bottonOrange,
                    textColor: ColorApp_Icon_border.bottonbrown,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Addannounce(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

Dialog _costumAlertDialog(
  BuildContext context, {
  required VoidCallback onPressedUnblock,
  required VoidCallback onPressedcancel,
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: context.widthPct(90),
      padding: EdgeInsets.all(context.heightPct(1)),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorApp_Icon_border.bottonbrown,
          width: context.heightPct(0.3),
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: ColorApp_Background.appbarecolor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Delete Announce",
                style: TextStyle(
                  fontSize: context.heightPct(3),
                  fontFamily: "InterBold",
                  color: Colors.red[900],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(3)),
            child: Center(
              child: Text(
                "do you want delete this announce",
                style: TextStyle(
                  fontSize: context.heightPct(2),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPressedUnblock,
                  name: "delete",
                  color: const Color.fromARGB(255, 185, 29, 29),
                ),
              ),
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPressedcancel,
                  name: "cancel",
                  color: ColorApp_Botton.bottonOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
