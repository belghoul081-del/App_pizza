import 'dart:io';
import 'package:app_owner/firebase/firestore/service/service_supplements.dart';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/provider/product/product_Provider.dart';
import 'package:app_owner/service/service_PhotoProduct.dart';
import 'package:app_owner/view/cart/widget/showDialog/show_card_dialg.dart';
import 'package:app_owner/view/products/modifi_product/Supliment_modifi.dart';
import 'package:app_owner/view/products/modifi_product/widget_IconImage.dart';
import 'package:app_owner/view/products/modifi_product/widget_textmodefi_product.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costom_showBottomSheet.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Modifi_Product_Page extends StatefulWidget {
  final Products_model product;
  const Modifi_Product_Page({super.key, required this.product});

  @override
  State<Modifi_Product_Page> createState() => _Modifi_Product_PageState();
}

class _Modifi_Product_PageState extends State<Modifi_Product_Page> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  File? _selectedImage;
  final ImagePickerService _imageService = ImagePickerService();
  bool _isBusy = false;

  Future<void> _pickImage(ImageSource choise) async {
    File? image = await _imageService.pickImage(choise);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  late Products_model tempProduct;
  @override
  void initState() {
    super.initState();
    tempProduct = widget.product.copy();
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => _costumAlertDialog(
        context,
        onPressedcancel: () => Navigator.pop(ctx, false),
        onPressedUnblock: () => Navigator.pop(ctx, true),
      ),
    );
    if (confirm != true) return;

    setState(() => _isBusy = true);
    try {
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      ).removeProduct(widget.product.id);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed("Home");
    } catch (e) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Deletion failed: $e')));
    }
  }

  Future<void> _save() async {
    await SupplementService.syncSupplementsToProducts();
    await SupplementService.initSupplements();
    if (tempProduct.name.trim().isEmpty || tempProduct.price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please enter corruct Name or Price')),
      );
      return;
    }

    setState(() => _isBusy = true);
    try {
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      ).updateProduct(tempProduct, newImageFile: _selectedImage);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Widget_appBar(context, title: "product details"),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image_modifi(
                    context,
                    image: widget.product.imagePath,
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
                  //name
                  Text_show_Product(
                    context: context,
                    title: "Name : ",
                    item: tempProduct.name,
                    onPressed: () {
                      TextEditingController nameController =
                          TextEditingController(text: tempProduct.name);

                      scaffoldKey.currentState!.showBottomSheet(
                        (context) => Widget_ShowBottomSheet(
                          height: 20,
                          controller: nameController,
                          onpressed: () {
                            setState(() {
                              tempProduct.name = nameController.text;
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
                    item: "${tempProduct.price} Da",
                    onPressed: () {
                      TextEditingController priceController =
                          TextEditingController(
                            text: tempProduct.price.toString(),
                          );

                      scaffoldKey.currentState!.showBottomSheet(
                        (context) => Widget_ShowBottomSheet(
                          height: 20,
                          controller: priceController,

                          onpressed: () {
                            setState(() {
                              tempProduct.price =
                                  int.tryParse(priceController.text) ??
                                  tempProduct.price;
                            });
                            Navigator.pop(context);
                          },
                          hintText: "enter new price",
                        ),
                      );
                    },
                  ),
                  //supliment
                  Sepliment_Widget(
                    product: widget.product,
                    scaffoldKey: scaffoldKey,
                    onChanged: () => setState(() {}),
                  ),
                  SizedBox(height: context.heightPct(5)),

                  /// delete / add
                  Row(
                    children: [
                      Expanded(
                        child: Widget_botton(
                          context,
                          text: "Delete",
                          onPressed: _isBusy ? () {} : _delete,
                          height: 7,
                          width: 40,
                          backgroundColor: const Color.fromARGB(
                            255,
                            198,
                            40,
                            40,
                          ),
                          textColor: ColorApp_Text.textbrown,
                        ),
                      ),
                      SizedBox(width: context.heightPct(1)),
                      Expanded(
                        child: Widget_botton(
                          context,
                          text: _isBusy ? "Saving..." : "Save",
                          onPressed: _isBusy ? () {} : _save,

                          height: 7,
                          width: 40,
                          backgroundColor: ColorApp_Botton.bottonOrange,
                          textColor: ColorApp_Text.textbrown,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.heightPct(3)),
                ],
              ),
            ),
          ),
          if (_isBusy)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
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
                "Deletion Confirmation",
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
                "Are you sure you want to permanently delete this product?",
                style: TextStyle(
                  fontSize: context.heightPct(1.75),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPressedUnblock,
                  name: "Delete",
                  color: const Color.fromARGB(255, 185, 28, 28),
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
