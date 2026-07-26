import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/firebase/firestore/service/orders_service.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/order/location_Model.dart';
import 'package:app_pizza_client/provider/cart/cart_Provider.dart';
import 'package:app_pizza_client/view/location/location_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Dialog costumAlertDialog(
  BuildContext context, {
  required int priceTotal,
  required Client_Model client,
  required List<Cart_model> items,
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: _ConfirmOrderContent(
      priceTotal: priceTotal,
      client: client,
      items: items,
    ),
  );
}

class _ConfirmOrderContent extends StatefulWidget {
  final int priceTotal;
  final Client_Model client;
  final List<Cart_model> items;

  const _ConfirmOrderContent({
    required this.priceTotal,
    required this.client,
    required this.items,
  });

  @override
  State<_ConfirmOrderContent> createState() => _ConfirmOrderContentState();
}

class _ConfirmOrderContentState extends State<_ConfirmOrderContent> {
  final OrdersFirestoreService _service = OrdersFirestoreService();
  bool _isSending = false;
  String? _confirmedOrderId;

  Location_Model? _selectedLocation;

  String getCharRange(String text, int maxLength, {bool withDots = true}) {
    // حماية الكود: إذا كان النص أصلاً أقصر من الحد المطلوب، نرجعه كما هو
    if (text.length <= maxLength) {
      return text;
    }

    // قص النص من الحرف الأول (المؤشر 0) حتى الحد الأقصى المطلوب (5 أو 9 مثلاً)
    String truncated = text.substring(0, maxLength);

    // إرجاع النص المقصوص؛ مع نقاط في نهايته إذا كان withDots مفصلاً، أو بدونه
    return withDots ? '$truncated...' : truncated;
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const LocationPickerPage()));
    if (result == null) return;

    setState(() {
      _selectedLocation = Location_Model(
        lat: result.latitude,
        lng: result.longitude,
      );
    });
  }

  Future<void> _confirm() async {
    setState(() => _isSending = true);
    try {
      final orderId = await _service.submitOrder(
        clientName: widget.client.name,
        clientNumber: widget.client.number,
        clientImage: widget.client.image,
        clientId: widget.client.uID,
        items: widget.items,
        totalPrice: widget.priceTotal,
        location: _selectedLocation,
      );

      if (!mounted) return;
      // نفرّغ السلة فقط بعد نجاح الإرسال الفعلي للطلب
      Provider.of<CartProvider>(context, listen: false).carts = [];

      setState(() {
        _confirmedOrderId = orderId;
        _isSending = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSending = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Request failed to send: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLocationSelected = _selectedLocation != null;
    final bool isOrderConfirmed = _confirmedOrderId != null;

    return Container(
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
            padding: EdgeInsets.symmetric(horizontal: context.heightPct(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${DateTime.now().hour}:${DateTime.now().minute}"),
                Text(
                  "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                ),
              ],
            ),
          ),
          if (isOrderConfirmed)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.heightPct(1)),
            child: WidgetTextRich_Dialog(
              context,
              text: "Order: ",
              content: getCharRange(_confirmedOrderId!, 12, withDots: false),
            ),
          ),
          WidgetTextRich_Dialog(
            context,
            text: "Name: ",
            content: widget.client.name,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.heightPct(7),
              top: context.heightPct(2),
              bottom: context.heightPct(1),
            ),
            child: WidgetTextRich_Dialog(
              context,
              text: "Price: ",
              content: "${widget.priceTotal} Da",
            ),
          ),

                    if (_confirmedOrderId != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.heightPct(1)),
              child: Center(
                child: Text(
                 "✅ Your request has been successfully submitted",
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: "InterBold",
                  ),
                ),
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Dialogbotton_Location(
                  context,
                  isLocationSet: isLocationSelected,
                  onPressed: (isOrderConfirmed) ? null : _pickLocation,
                ),
              ),
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  isLoading: _isSending,
                  isDone: isOrderConfirmed,
                  onPressed: (isLocationSelected && !isOrderConfirmed)
                      ? _confirm
                      : null,
                  color: isLocationSelected && !isOrderConfirmed
                      ? ColorApp_Botton.bottonOrange
                      : const Color.fromARGB(255, 168, 168, 168),
                  name: "Confirm",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget Dialogbotton_Location(
  BuildContext context, {
  required bool isLocationSet,
  required VoidCallback? onPressed,
}) {
  return MaterialButton(
    onPressed: onPressed,
    padding: EdgeInsets.zero,
    child: Container(
      height: context.heightPct(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDE6C8),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: ColorApp_Icon_border.bottonbrown,
              size: context.heightPct(5),
            ),
            Text(
              isLocationSet ? "Selected" : "Location",
              style: TextStyle(
                color: ColorApp_Text.textbrown,
                fontSize: context.heightPct(2.5),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget Dialogbotton_Confirm(
  BuildContext context, {
  required VoidCallback? onPressed,
  bool isLoading = false,
  bool isDone = false,
  required Color color,
  required String name,
}) {
  return MaterialButton(
    onPressed: (isLoading || isDone) ? null : onPressed,
    padding: EdgeInsets.zero,
    child: Container(
      height: context.heightPct(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                isDone ? "Sent" : name,
                style: TextStyle(
                  color: ColorApp_Text.textbrown,
                  fontSize: context.heightPct(2.5),
                ),
              ),
      ),
    ),
  );
}

Widget WidgetTextRich_Dialog(
  BuildContext context, {
  required String text,
  required String content,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.heightPct(3),
      vertical: context.heightPct(0.5),
    ),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: context.heightPct(2),
              fontFamily: "InterBold",
              color: ColorApp_Botton.bottonOrange,
            ),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
              fontSize: context.heightPct(2),
              fontFamily: "InterBold",
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

