import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_owner/provider/cart/sepliment_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButttonOfSepliment extends StatefulWidget {
  final String name;
  final int price;
  final Function(bool?) onchange; // تأكد من مطابقة هذا النوع
  const ButttonOfSepliment({
    super.key,
    required this.name,
    required this.price,
    required this.onchange,
  });

  @override
  State<ButttonOfSepliment> createState() => _ButttonOfSeplimentState();
}

class _ButttonOfSeplimentState extends State<ButttonOfSepliment> {
  final currentSupplement = Sepliment_model;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SeplimentProvider>(context);
    bool isChecked = provider.carts.any((item) => item.name == widget.name);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.name} (${widget.price} Da)",
          style: TextStyle(
            fontSize: context.heightPct(2),
            fontWeight: FontWeight.bold,
          ),
        ),
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            widget.onchange(value);
          },
        ),
      ],
    );
  }
}
