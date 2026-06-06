import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/categorymodel/category_Model.dart';
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
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: Category_Data.categories.length,
      itemBuilder: (context, index) {
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
      },
    ),
  );
}

Widget card_category_I({
  required BuildContext context,
  required category,
  required isSelected,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: context.heightPct(2),
      vertical: context.heightPct(0.5),
    ),

    decoration: BoxDecoration(
      color: ColorApp_Botton.bottonOrange,
      border: BoxBorder.all(color: ColorApp_Botton.bottonOrange),

      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(context.heightPct(0)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorApp_Background.backgroundcolorII,
            border: Border.all(color: ColorApp_Botton.bottonOrange, width: 0),
          ),
          child: Image.asset(
            category.imagePath,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.fastfood),
          ),
        ),
        Text(
          category.name,
          style: TextStyle(
            fontFamily: "SemiBold",
            fontWeight: FontWeight.w900,
            fontSize: context.heightPct(2),
            color: ColorApp_Text.textbrown,
          ),
        ),
      ],
    ),
  );
}

Widget card_category_II({
  required BuildContext context,
  required category,
  required isSelected,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: context.heightPct(2),
      vertical: context.heightPct(0.5),
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: ColorApp_Background.backgroundcolorII,
      border: BoxBorder.all(color: ColorApp_Botton.bottonOrange),
    ),
    child: Container(
      padding: EdgeInsets.all(context.heightPct(category.size)),
      child: Image.asset(
        category.imagePath,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.fastfood),
      ),
    ),
  );
}
