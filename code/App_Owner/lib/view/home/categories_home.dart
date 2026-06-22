import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_category/category_Model.dart';
import 'package:app_pizza_owner/view/home/widget/categories_bar/favorit_category.dart';
import 'package:app_pizza_owner/view/home/widget/categories_bar/no_sel_category.dart';
import 'package:app_pizza_owner/view/home/widget/categories_bar/sel_category.dart';
import 'package:flutter/material.dart';

Widget categories({
  required BuildContext context,
  required int selectedIndex,
  required Function(int) onCategorySelected,
}) {
  double screenWidht = MediaQuery.of(context).size.width;

  return Container(
    height: context.heightPct(7),
    width: screenWidht,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: () => onCategorySelected(-1),
          child: card_category_Favorit(
            context: context,
            favorit: selectedIndex == -1,
          ),
        ),
        ...List.generate(Category_Data.categories.length, (index) {
          final category = Category_Data.categories[index];
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              onCategorySelected(index);
            },
            child: isSelected
                ? card_category_I(
                    context: context,
                    category: category,
                    isSelected: isSelected,
                  )
                : card_category_II(
                    context: context,
                    category: category,
                    isSelected: isSelected,
                  ),
          );
        }),
      ],
    ),
  );
}



        // 