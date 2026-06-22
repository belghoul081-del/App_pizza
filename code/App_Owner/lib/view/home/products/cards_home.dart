import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/view/home/products/widget/products/cards_product.dart';
import 'package:flutter/material.dart';

class Products_cards_home extends StatefulWidget {
  final String selectedCategory;
  const Products_cards_home({super.key, required this.selectedCategory});

  @override
  State<Products_cards_home> createState() => _Products_cards_homeState();
}

class _Products_cards_homeState extends State<Products_cards_home> {
  @override
  Widget build(BuildContext context) {
    final filterProducts = Products_Data.cards_of_Products.where((protected) {
      if (widget.selectedCategory == "favorit") {
        return protected.favorit;
      }
      return protected.categories == widget.selectedCategory;
    }).toList();
    return GridView.builder(
      padding: EdgeInsets.only(
        top: context.heightPct(1),
        left: context.heightPct(2),
        right: context.heightPct(2),
        bottom: context.heightPct(5),
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.heightPct(1.2),
        mainAxisSpacing: context.heightPct(1),
        childAspectRatio: 0.85,
      ),

      itemCount: filterProducts.length,
      itemBuilder: (context, index) {
        final currentProduct = filterProducts[index];
        return Widget_Cards_product(
          product: currentProduct,
          onChanged: () {
            setState(() {});
          },
        );
      },
    );
  }
}
