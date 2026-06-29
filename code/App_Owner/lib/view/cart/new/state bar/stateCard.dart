import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/order/state_order_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget state_Card({
  required BuildContext context,
  required int selectedIndex,
  required onCategorySelected,
}) {
  double screenWidht = MediaQuery.of(context).size.width;

  return Container(
    height: context.heightPct(6),
    width: screenWidht,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: context.heightPct(1)),
      itemCount: State_Order_Date.state.length + 1,
      separatorBuilder: (context, index) =>
          SizedBox(width: context.heightPct(1.5)),
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () => onCategorySelected(0),
            child: cont_ALL(context, isSelected: selectedIndex == 0),
          );
        }

        final state = State_Order_Date.state[index - 1];
        final itemIndex = index;
        final isSelected = selectedIndex == itemIndex;

        return GestureDetector(
          onTap: () => onCategorySelected(itemIndex),
          child: card_State(
            context: context,
            State: state,
            isSelected: isSelected,
          ),
        );
      },
    ),
  );
}

Widget card_State({
  required BuildContext context,
  required State,
  required isSelected,
}) {
  return Container(
    height: context.heightPct(6),
    width: context.heightPct(6),

    padding: State.imagePath == "assets/icons/order/Icon_delivery.svg"
        ? EdgeInsets.symmetric(
            horizontal: context.heightPct(0.7),
            vertical: context.heightPct(1.2),
          )
        : EdgeInsets.all(context.heightPct(0.7)),
    decoration: BoxDecoration(
      color: isSelected
          ? ColorApp_Botton.bottonOrange
          : const Color.fromARGB(255, 252, 241, 227),
      border: BoxBorder.all(color: ColorApp_Icon_border.bottonbrown),

      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: SvgPicture.asset(State.imagePath, fit: BoxFit.fill),
  );
}

Container cont_ALL(BuildContext context, {required bool isSelected}) {
  return Container(
    height: context.heightPct(6),
    width: context.heightPct(10),
    padding: EdgeInsets.all(context.heightPct(1.2)),

    decoration: BoxDecoration(
      color: isSelected
          ? ColorApp_Botton.bottonOrange
          : const Color.fromARGB(255, 252, 241, 227),
      border: BoxBorder.all(color: ColorApp_Icon_border.bottonbrown),

      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Center(
      child: Text("ALL", style: TextStyle(color: ColorApp_Text.textbrown)),
    ),
  );
}
