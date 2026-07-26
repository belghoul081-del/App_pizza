import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

class ButttonOfSepliment extends StatelessWidget {
  final String name;
  final int price;
  final bool value;
  final ValueChanged<bool?> onchange;

  const ButttonOfSepliment({
    super.key,
    required this.name,
    required this.price,
    required this.value,
    required this.onchange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${name} (${price} Da)",
          style: TextStyle(
            fontSize: context.heightPct(2),
            fontWeight: FontWeight.bold,
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onchange,
        ),
      ],
    );
  }
}
