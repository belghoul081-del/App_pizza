import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/product/product_Provider.dart';
import 'package:app_owner/view/products/widget/products/cards_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products_cards_home extends StatefulWidget {
  final String selectedCategory;
  const Products_cards_home({super.key, required this.selectedCategory});

  @override
  State<Products_cards_home> createState() => _Products_cards_homeState();
}

class _Products_cards_homeState extends State<Products_cards_home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.error != null) {
          return Padding(
            padding: EdgeInsets.all(context.heightPct(3)),
            child: Center(
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (provider.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final filterProducts = provider.products.where((p) {
          return p.categories == widget.selectedCategory;
        }).toList();

        return GridView.builder(
          key: ValueKey(widget.selectedCategory),
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
            final product = filterProducts[index];
            return Widget_Cards_product(
              key: ValueKey(product.id),
              product: product,
              onChanged: () {
                // setState(() {});
                // provider.notifyListeners();
              },
            );
          },
        );
      },
    );
  }
}
