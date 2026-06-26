import 'dart:io';

import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/service/service_Addproduct.dart';
import 'package:app_pizza_owner/service/service_PhotoProduct.dart';
import 'package:app_pizza_owner/view/products/modifi_product/Supliment_modifi.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_IconImage.dart';
import 'package:app_pizza_owner/view/products/modifi_product/widget_textmodefi_product.dart';
import 'package:app_pizza_owner/view/products/widget/products/botton_Cards.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_owner/widget/custom/costom_showBottomSheet.dart';
import 'package:app_pizza_owner/widget/custom/costum_Button.dart';
import 'package:app_pizza_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Add_Product_Page extends StatefulWidget {
  const Add_Product_Page({super.key});

  @override
  State<Add_Product_Page> createState() => _Add_Product_PageState();
}

class _Add_Product_PageState extends State<Add_Product_Page> {
  //
  String name = "enter name";
  int price = 0;
  String imagePath = 'assets/images/prodect_images/pizza/pizza_4Fromage.png';
  String categories = '';

  final product = Products_Data();

  final List newProduct = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  File? _selectedImage;
  final ImagePickerService _imageService = ImagePickerService();

  Future<void> _pickImage(ImageSource choise) async {
    File? image = await _imageService.pickImage(choise);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Widget_appBar(context, title: "add product"),
      body: Center(
        child: Column(
          children: [
            Image_modifi(
              context,
              image: imagePath,
              selectedImage: _selectedImage,
              scaffoldKey: scaffoldKey,
              onPressedGallery: () {
                _pickImage(ImageSource.gallery);
              },
              onPressedCamera: () {
                _pickImage(ImageSource.camera);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.heightPct(2)),
              child: DashedLineDivider(
                height: 3,
                dashWidth: 3,
                dashSpace: 0,
                color: ColorApp_Icon_border.bottonbrown,
              ),
            ),
            //name
            Text_show_Product(
              context: context,
              title: "Name : ",
              item: name,
              onPressed: () {
                TextEditingController nameController = TextEditingController(
                  text: name,
                );

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Widget_ShowBottomSheet(
                    height: 20,
                    controller: nameController,
                    onpressed: () {
                      setState(() {
                        name = nameController.text;
                      });
                      Navigator.pop(context);
                    },
                    hintText: "enetr new name",
                  ),
                );
              },
            ),
            //price
            Text_show_Product(
              context: context,
              title: "Price : ",
              item: "${price} Da",
              onPressed: () {
                TextEditingController priceController = TextEditingController(
                  text: price.toString(),
                );

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Widget_ShowBottomSheet(
                    height: 20,
                    controller: priceController,
                    onpressed: () {
                      setState(() {
                        price = int.tryParse(priceController.text) ?? 0;
                      });
                      Navigator.pop(context);
                    },
                    hintText: "enter new price",
                  ),
                );
              },
            ),

            // أضف هذا داخل الـ Column في صفحة Add_Product_Page
            const SizedBox(height: 30),

            Widget_botton(
              context,
              text: 'Add Product',
              height: 7,
              width: 50,
              backgroundColor: ColorApp_Botton.bottonOrange,
              textColor: ColorApp_Icon_border.bottonbrown,
              onPressed: () {
                // 1. التحقق من أن المستخدم أدخل بيانات صحيحة ولم يترك القيم الافتراضية
                if (name == "enter name" ||
                    price <= 0 ||
                    _selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرجاء إدخال الاسم والسعر واختيار صورة'),
                    ),
                  );
                  return;
                }

                // 2. استدعاء دالة الإضافة من السيرفيس
                Service_Addproduct.addProduct(
                  name: name,
                  price: price,
                  type: 0, // قم بتعديلها حسب منطقك البرمجي
                  categories:
                      categories, // تأكد من إعطاء قيمة لهذه المتغير قبل الحفظ
                  productId: Products_model(
                    id: '',
                    name: name,
                    price: price,
                    categories: categories,
                    imagePath: _selectedImage!.path,
                  ),
                  imagePath: _selectedImage!.path,
                );

                // 3. العودة إلى الصفحة السابقة بعد إتمام الحفظ
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
