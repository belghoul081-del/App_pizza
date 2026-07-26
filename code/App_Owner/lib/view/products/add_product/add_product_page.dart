import 'dart:io';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/firestore/service/service_supplements.dart';
import 'package:app_owner/models/model_category/category_Model.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/provider/product/product_Provider.dart';
import 'package:app_owner/service/service_Add_removeproduct.dart';
import 'package:app_owner/service/service_PhotoProduct.dart';
import 'package:app_owner/view/products/modifi_product/widget_textmodefi_product.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costom_showBottomSheet.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:app_owner/widget/custom/costum_image_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  String iconCategories = '';

  final product = Products_Data();

  final List newProduct = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey _menukey = GlobalKey();
  File? _selectedImage;
  final ImagePickerService _imageService = ImagePickerService();
  bool _isSaving = false;

  Future<void> _pickImage(ImageSource choise) async {
    File? image = await _imageService.pickImage(choise);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _submit() async {
    if (name == "enter name" || name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please enter a product name')),
      );
      return;
    }
    if (price <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('please enter a price')));
      return;
    }
    if (categories.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('please choose a category')));
      return;
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('please choose a photo')));
      return;
    }

    setState(() => _isSaving = true);

    final newProduct = Products_model(
      id: Service_Addproduct.generateUniqueId(categories),
      name: name,
      price: price,
      categories: categories,
      imagePath: '',
      supplements: SupplementService.getSupplementsForCategory(categories),
    );

    try {
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      ).addProduct(newProduct, _selectedImage!);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add product: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Widget_appBar(context, title: "add product"),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image_Add(
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
                      vertical: context.heightPct(2),
                    ),
                    child: DashedLineDivider(
                      height: 3,
                      dashWidth: 3,
                      dashSpace: 0,
                      color: ColorApp_Icon_border.bottonbrown,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.heightPct(2),
                        bottom: context.heightPct(1),
                      ),
                      child: Stack(
                        children: [
                          Widget_popupMenuCategory(
                            context,
                            _menukey,
                            onSelected: (value) {
                              setState(() {
                                categories = value;
                                var selectCategories = Category_Data.categories
                                    .firstWhere(
                                      (cat) => cat.categories == value,
                                    );
                                iconCategories = selectCategories.imagePath;
                              });
                            },
                            categoriesList: Category_Data.categories,
                          ),
                          InkWell(
                            onTap: () {
                              dynamic state = _menukey.currentState;
                              state.showButtonMenu();
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              height: context.heightPct(7),
                              width: context.heightPct(7),
                              decoration: BoxDecoration(
                                color: ColorApp_Background.backgroundcolorII,
                                border: Border.all(
                                  color: ColorApp_Botton.bottonOrange,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: iconCategories != ''
                                  ? Image.asset(
                                      iconCategories,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/cub_icone.svg",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //name
                  Text_show_Product(
                    context: context,
                    title: "Name : ",
                    item: name,
                    onPressed: () {
                      TextEditingController nameController =
                          TextEditingController(text: name);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Widget_ShowBottomSheet(
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
                      TextEditingController priceController =
                          TextEditingController(text: price.toString());

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Widget_ShowBottomSheet(
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
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Widget_botton(
                    context,
                    text: _isSaving ? 'Saving...' : 'Add Product',
                    height: 7,
                    width: 50,
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

Widget Widget_popupMenuCategory(
  BuildContext context,
  GlobalKey _menukey, {
  required Function(String) onSelected,
  required List<Category_model> categoriesList,
}) {
  return PopupMenuButton<String>(
    key: _menukey,
    onSelected: onSelected,
    itemBuilder: (BuildContext context) => categoriesList.map((cat) {
      return PopupMenuItem<String>(
        value: cat.categories,
        child: Row(
          children: [
            Image.asset(cat.imagePath, width: 30, height: 30),
            const SizedBox(width: 10),
            Text(cat.name),
          ],
        ),
      );
    }).toList(),
    child: const SizedBox.shrink(),
  );
}

Widget Image_Add(
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
                height: context.heightPct(25),
                width: context.heightPct(
                  25,
                ),
                decoration: BoxDecoration(
                  color: ColorApp_Icon_border.bottonbrown,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image.file(selectedImage, fit: BoxFit.cover),
                ),
              )
            : Widget_Images_Cards(context, image: image, size: 25),
        Positioned(
          right: 5,
          bottom: 5,
          child: Container(
            height: sizeBB,
            width: sizeBB,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorApp_Botton.bottonOrange),
              color: ColorApp_Background.backgroundcolorII,
            ),

            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.showBottomSheet(
                  (context) => Container(
                    height: context.heightPct(20),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorApp_Background.appbarecolor,
                      border: Border.all(
                        color: ColorApp_Icon_border.bottonbrown,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Text(
                            "choise image",
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
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ],
    ),
  );
}
