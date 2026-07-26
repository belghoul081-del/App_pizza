import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/firestore/service/service_supplements.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/view/products/modifi_product/widget_textModefi.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';

class Sepliment_Widget extends StatefulWidget {
  final Products_model product;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final VoidCallback? onChanged;

  const Sepliment_Widget({
    super.key,
    required this.product,
    required this.scaffoldKey,
    this.onChanged,
  });

  @override
  State<Sepliment_Widget> createState() => _Sepliment_WidgetState();
}

class _Sepliment_WidgetState extends State<Sepliment_Widget> {
  late Sepliment_model sepliment;

  void _notifyChanged() {
    if (mounted) setState(() {});
    widget.onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.heightPct(2),
        vertical: context.heightPct(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Supliment",
            style: TextStyle(
              fontSize: context.heightPct(3),
              fontFamily: "InterBold",
              color: ColorApp_Text.textbrown,
            ),
          ),
          Row(
            children: [
              Container(
                height: context.heightPct(4),
                width: context.heightPct(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  color: ColorApp_Background.appbarecolor,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    TextEditingController newNameController =
                        TextEditingController();
                    TextEditingController newPriceController =
                        TextEditingController();

                    int isSpecific = 0;

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (sheetContext) => StatefulBuilder(
                        builder: (sheetContext, setBottomSheetState) =>
                            Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(sheetContext).viewInsets.bottom,
                          ),
                          child: SingleChildScrollView(
                            child: Container(
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => setBottomSheetState(
                                            () => isSpecific = 0,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: isSpecific == 0
                                                  ? ColorApp_Botton.bottonOrange
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: ColorApp_Icon_border
                                                    .bottonbrown,
                                              ),
                                            ),
                                            child: Text(
                                              "Only",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: context.heightPct(1)),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => setBottomSheetState(
                                            () => isSpecific = 1,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: isSpecific == 1
                                                  ? ColorApp_Botton.bottonOrange
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: ColorApp_Icon_border
                                                    .bottonbrown,
                                              ),
                                            ),
                                            child: Text(
                                              "Specific",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: context.heightPct(1)),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => setBottomSheetState(
                                            () => isSpecific = 2,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: isSpecific == 2
                                                  ? ColorApp_Botton.bottonOrange
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: ColorApp_Icon_border
                                                    .bottonbrown,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Text(
                                              "Global",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.heightPct(2)),

                                  Text_Modefie_Product(
                                    context: sheetContext,
                                    controller: newNameController,
                                    hintText: 'Enter name',
                                  ),
                                  SizedBox(height: context.heightPct(2)),
                                  Text_Modefie_Product(
                                    context: sheetContext,
                                    controller: newPriceController,
                                    hintText: 'Enter price',
                                  ),

                                  SizedBox(height: context.heightPct(2)),
                                  Widget_botton(
                                    sheetContext,
                                    text: 'Add',
                                    onPressed: () async {
                                      if (newNameController.text.isNotEmpty &&
                                          newPriceController.text.isNotEmpty) {
                                        final newSupplement = Sepliment_model(
                                          id: SupplementService
                                              .generateUniqueId(),
                                          name: newNameController.text,
                                          price: int.tryParse(
                                                newPriceController.text,
                                              ) ??
                                              0,
                                          categories: isSpecific == 1
                                              ? widget.product.categories
                                              : '',
                                          ProductId: isSpecific == 0
                                              ? widget.product.id
                                              : '',
                                        );

                                        Sepliment_Data.general_supplements
                                            .add(newSupplement);
                                        await SupplementsFirestoreService
                                            .saveGeneralSupplements(
                                          Sepliment_Data.general_supplements,
                                        );
                                        
                                        await SupplementService.syncSupplementsToProducts();
                                        if (!sheetContext.mounted) return;

                                        _notifyChanged();

                                        Navigator.pop(sheetContext);
                                      }
                                    },
                                    height: 7,
                                    width: 30,
                                    backgroundColor:
                                        ColorApp_Botton.bottonOrange,
                                    textColor:
                                        ColorApp_Background.backgroundcolor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: context.heightPct(3),
                    color: ColorApp_Icon_border.bottonbrown,
                  ),
                ),
              ),

              SizedBox(width: context.heightPct(1)),
              Container(
                height: context.heightPct(4),
                width: context.heightPct(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  color: ColorApp_Background.appbarecolor,
                ),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (listSheetContext) => StatefulBuilder(
                        builder: (listSheetContext, setSheetState) =>
                            Container(
                          height: listSheetContext.heightPct(80),
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
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "Supliment",
                                  style: TextStyle(
                                    fontSize: listSheetContext.heightPct(4),
                                    fontFamily: "InterBold",
                                    color: ColorApp_Text.textbrown,
                                  ),
                                ),
                                SizedBox(height: listSheetContext.heightPct(5)),
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      final category =
                                          widget.product.categories;

                                      final productSpecific = Sepliment_Data
                                          .general_supplements
                                          .where((s) =>
                                              s.ProductId == widget.product.id)
                                          .toList();
                                      final categorySpecific = Sepliment_Data
                                          .general_supplements
                                          .where((s) =>
                                              s.categories == category &&
                                              s.ProductId == '')
                                          .toList();
                                      final global = Sepliment_Data
                                          .general_supplements
                                          .where((s) =>
                                              s.categories == '' &&
                                              s.ProductId == '')
                                          .toList();
                                      List<dynamic> displayList = [];

                                      if (productSpecific.isNotEmpty) {
                                        displayList.add("Product Specific:");
                                        displayList.addAll(productSpecific);
                                      }
                                      if (categorySpecific.isNotEmpty) {
                                        displayList.add("Category Specific:");
                                        displayList.addAll(categorySpecific);
                                      }
                                      if (global.isNotEmpty) {
                                        displayList.add("Global:");
                                        displayList.addAll(global);
                                      }
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: displayList.length,
                                        itemBuilder: (context, index) {
                                          final item = displayList[index];

                                          if (item is String) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: context.heightPct(2),
                                                top: context.heightPct(2),
                                                bottom: context.heightPct(1),
                                              ),
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize:
                                                      context.heightPct(3),
                                                  fontFamily: "InterBold",
                                                  color: Color.fromARGB(
                                                    255,
                                                    218,
                                                    127,
                                                    0,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: context.heightPct(2),
                                              top: context.heightPct(2),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "- ${item.name}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        context.heightPct(2.5),
                                                    fontFamily: "InterBold",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${item.price}Da",
                                                      style: TextStyle(
                                                        fontSize: context
                                                            .heightPct(2.5),
                                                        fontFamily:
                                                            "InterBold",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          context.heightPct(1),
                                                    ),
                                                    Container(
                                                      height:
                                                          context.heightPct(4),
                                                      width:
                                                          context.heightPct(4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        border: Border.all(
                                                          color:
                                                              ColorApp_Icon_border
                                                                  .bottonbrown,
                                                        ),
                                                        color:
                                                            ColorApp_Background
                                                                .backgroundcolorII,
                                                      ),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          TextEditingController
                                                              suplimentController =
                                                              TextEditingController(
                                                            text: item.name,
                                                          );
                                                          TextEditingController
                                                              suplimentPriceController =
                                                              TextEditingController(
                                                            text: item.price
                                                                .toString(),
                                                          );

                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            builder: (editSheetContext) =>
                                                                StatefulBuilder(
                                                              builder: (
                                                                editSheetContext,
                                                                setBottomSheetState,
                                                              ) =>
                                                                  Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom: MediaQuery.of(
                                                                          editSheetContext)
                                                                      .viewInsets
                                                                      .bottom,
                                                                ),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorApp_Background
                                                                          .appbarecolor,
                                                                      border: Border
                                                                          .all(
                                                                        color:
                                                                            ColorApp_Icon_border.bottonbrown,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                          30,
                                                                        ),
                                                                        topRight:
                                                                            Radius.circular(
                                                                          30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                      20,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Text_Modefie_Product(
                                                                          context:
                                                                              editSheetContext,
                                                                          controller:
                                                                              suplimentController,
                                                                          hintText:
                                                                              'enter new supliment',
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              context.heightPct(
                                                                            2,
                                                                          ),
                                                                        ),
                                                                        Text_Modefie_Product(
                                                                          context:
                                                                              editSheetContext,
                                                                          controller:
                                                                              suplimentPriceController,
                                                                          hintText:
                                                                              'enter new supliment',
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Widget_botton(
                                                                              editSheetContext,
                                                                              text: 'save',
                                                                              onPressed: () async {
                                                                                if (suplimentController.text.isNotEmpty &&
                                                                                    suplimentPriceController.text.isNotEmpty) {
                                                                                  await SupplementService.editSupplement(
                                                                                    id: item.id,
                                                                                    newName: suplimentController.text,
                                                                                    newPrice: int.tryParse(
                                                                                          suplimentPriceController.text,
                                                                                        ) ??
                                                                                        0,
                                                                                  );

                                                                                  if (!editSheetContext.mounted) return;

                                                                                  setSheetState(() {});
                                                                                  _notifyChanged();

                                                                                  Navigator.pop(editSheetContext);
                                                                                }
                                                                              },
                                                                              height: 7,
                                                                              width: 30,
                                                                              backgroundColor: ColorApp_Botton.bottonOrange,
                                                                              textColor: ColorApp_Icon_border.bottonbrown,
                                                                            ),
                                                                            Widget_botton(
                                                                              editSheetContext,
                                                                              text: 'Delete',
                                                                              onPressed: () async {
                                                                                await SupplementService.deleteSupplement(
                                                                                  id: item.id,
                                                                                );

                                                                                if (!editSheetContext.mounted) return;

                                                                                setSheetState(() {});
                                                                                _notifyChanged();

                                                                                Navigator.pop(editSheetContext);

                                                                                ScaffoldMessenger.of(
                                                                                  context,
                                                                                ).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      "Delete Suppliment : ${item.name}",
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              height: 7,
                                                                              width: 30,
                                                                              backgroundColor: Colors.red,
                                                                              textColor: ColorApp_Icon_border.bottonbrown,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: context
                                                              .heightPct(3),
                                                          color:
                                                              ColorApp_Icon_border
                                                                  .bottonbrown,
                                                        ),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        constraints:
                                                            BoxConstraints(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: context.heightPct(3),
                    color: ColorApp_Icon_border.bottonbrown,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}