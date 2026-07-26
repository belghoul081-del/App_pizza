import 'dart:io';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/storage/storage_service.dart';
import 'package:app_owner/service/service_PhotoProduct.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addannounce extends StatefulWidget {
  const Addannounce({super.key});

  @override
  State<Addannounce> createState() => _AddannounceState();
}

class _AddannounceState extends State<Addannounce> {
  String imagePath = 'assets/images/home_images/announc/announc.png';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  File? _selectedImage;
  final ImagePickerService_Announcement _imageService =
      ImagePickerService_Announcement();
  bool _isSaving = false;

  Future<void> _pickImage(ImageSource choice) async {
    File? image = await _imageService.pickImage(choice);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

   Future<void> _submit() async {
    // 1. التحقق من أن المستخدم قام باختيار صورة بالفعل
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first")),
      );
      return;
    }

    // 2. تفعيل شاشة التحميل (السيركل)
    setState(() {
      _isSaving = true;
    });

    try {
      // 3. توليد معرّف فريد للإعلان الحالي (باستخدام الوقت الحالي كمثال)
      final String idAnnounce = DateTime.now().millisecondsSinceEpoch.toString();

      // 4. استدعاء دالة الرفع إلى 
      // Cloudinary
      // من كود الـ الخاص بك
      //StorageService 
      final String imageUrl = await StorageService().uploadannounceImage(
        announceId: idAnnounce,
        imageFile: _selectedImage!,
      );

      // 5. حفظ رابط الصورة وبيانات الإعلان في الفايربيس (Firestore)
      // (ملاحظة: يمكنك تعديل اسم الـ Collection والحقول حسب تصميم قاعدة بياناتك)
      await FirebaseFirestore.instance
    .collection('announce')
    .doc(idAnnounce)
    .set({
  'id': idAnnounce,
  'imagePath': imageUrl,   // كان 'imageUrl' — لازم يطابق اسم الحقل في كل مكان آخر
  'createdAt': FieldValue.serverTimestamp(),
});

      // 6. في حال النجاح التام: اعرض رسالة نجاح وأغلق الصفحة للعودة للخلف
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Announcement added successfully!")),
        );
        Navigator.pop(context); 
      }
    } catch (e) {
      // 7. في حال حدوث أي خطأ أثناء الرفع أو الحفظ (مثل انقطاع الإنترنت)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save announcement: $e")),
        );
      }
    } finally {
      // 8. إيقاف السيركل وإعادة الواجهة لطبيعتها في كل الأحوال (سواء نجحت العملية أو فشلت)
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Widget_appBar(context, title: "Add Announcement"),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.heightPct(2)),
              child: Column(
                children: [
                  Image_AddAnnouncement(
                    context,
                    image: imagePath,
                    selectedImage: _selectedImage,
                    scaffoldKey: scaffoldKey,
                    onPressedGallery: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                    onPressedCamera: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(3),
                    ),
                    child: DashedLineDivider(
                      height: 3,
                      dashWidth: 3,
                      dashSpace: 0,
                      color: ColorApp_Icon_border.bottonbrown,
                    ),
                  ),
                  Widget_botton(
                    context,
                    text: _isSaving ? 'Saving...' : 'Add announcement',
                    height: 7,
                    width: 60,
                    backgroundColor: ColorApp_Botton.bottonOrange,
                    textColor: ColorApp_Icon_border.bottonbrown,
                    onPressed: _isSaving ? () {} : _submit,
                  ),
                  SizedBox(height: context.heightPct(3)),
                ],
              ),
            ),
          ),
          if (_isSaving)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

Widget Image_AddAnnouncement(
  BuildContext context, {
  required String image,
  required VoidCallback onPressedGallery,
  required VoidCallback onPressedCamera,
  required GlobalKey<ScaffoldState> scaffoldKey,
  File? selectedImage,
}) {
  double sizeBB = context.heightPct(5);

  return Padding(
    padding: EdgeInsets.only(top: context.heightPct(1)),
    child: Stack(
      children: [
        selectedImage != null
            ? Container(
                width: double.infinity,
                height: context.heightPct(
                  15,
                ), // 💡 متناسق تماماً مع مساحة العرض الـ 3:1
                decoration: BoxDecoration(
                  color: ColorApp_Icon_border.bottonbrown,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.file(selectedImage, fit: BoxFit.cover),
                ),
              )
            // كرت العرض الافتراضي قبل الاختيار
            : _Widget_Images(context, image: image),

        Positioned(
          right: 10,
          bottom: 10,
          child: Container(
            height: sizeBB,
            width: sizeBB,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorApp_Botton.bottonOrange),
              color: ColorApp_Background.backgroundcolorII,
            ),
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.showBottomSheet(
                  (context) => Container(
                    height: context.heightPct(20),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorApp_Background.appbarecolor,
                      border: Border.all(
                        color: ColorApp_Icon_border.bottonbrown,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Text(
                            "Choice image",
                            style: TextStyle(
                              color: ColorApp_Text.textbrown,
                              fontSize: context.heightPct(3),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Widget_botton(
                                context,
                                text: 'gallery',
                                onPressed: onPressedGallery,
                                height: 5,
                                width: 40,
                                backgroundColor: ColorApp_Botton.bottonOrange,
                                textColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Widget_botton(
                                context,
                                text: 'camera',
                                onPressed: onPressedCamera,
                                height: 5,
                                width: 40,
                                backgroundColor: ColorApp_Botton.bottonOrange,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.image,
                size: context.heightPct(3.5),
                color: ColorApp_Icon_border.bottonbrown,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _Widget_Images(BuildContext context, {required String image}) {
  Widget imageWidget;
  if (image.isEmpty) {
    imageWidget = const Icon(Icons.image_not_supported, color: Colors.white);
  } else if (image.startsWith('http://') || image.startsWith('https://')) {
    imageWidget = Image.network(
      image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, color: Colors.white),
    );
  } else if (image.startsWith('assets/')) {
    imageWidget = Image.asset(image, fit: BoxFit.cover);
  } else {
    imageWidget = Image.file(File(image), fit: BoxFit.cover);
  }

  return Container(
    width: double.infinity,
    height: context.heightPct(15),
    decoration: BoxDecoration(
      color: ColorApp_Icon_border.bottonbrown,
      shape: BoxShape.circle,
      border: Border.all(color: ColorApp_Icon_border.bottonbrown),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: imageWidget,
    ),
  );
}
