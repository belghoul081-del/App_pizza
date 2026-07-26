import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/order/order_Model.dart';
import 'package:app_pizza_client/provider/order/order_Provider.dart';
import 'package:app_pizza_client/view/cart/widget/showDialog/show_card_dialg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Dialog activeOrderDialog(BuildContext context, {required Order_Model order}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: _ActiveOrderContent(order: order),
  );
}

class _ActiveOrderContent extends StatefulWidget {
  final Order_Model order;
  const _ActiveOrderContent({required this.order});

  @override
  State<_ActiveOrderContent> createState() => _ActiveOrderContentState();
}

class _ActiveOrderContentState extends State<_ActiveOrderContent> {
  bool _isDeleting = false;

  bool get _canDelete => widget.order.status.state == 'waiting';
  String textWW(String text) {
    if (text == 'Delivery') {
      return "You cannot place a new order, your order is out for delivery";
    }
    if (text == 'Done' || text == 'Cook') {
      return "You cannot place a new order, the order is being prepared";
    }
    if (text == 'waiting') {
      return "Do you want to cancel the order?";
    }
    return "Please wait for two minutes to order again";
  }

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

  Future<void> _delete() async {
    setState(() => _isDeleting = true);
    final success = await Provider.of<OrderProvider>(
      context,
      listen: false,
    ).deleteOrder(widget.order.orderId);
    if (!mounted) return;
    setState(() => _isDeleting = false);
    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The order could not be deleted; it may have already been accepted by the restaurant.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "You have a request pending",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.heightPct(2.6),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.heightPct(3),
              vertical: context.heightPct(1),
            ),
            child: Text(
              textWW(widget.order.status.state),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: context.heightPct(1.9)),
            ),
          ),
          WidgetTextRich_Dialog(
            context,
            text: "Order: ",
            content: getCharRange(widget.order.orderId, 12, withDots: false),
          ),
          WidgetTextRich_Dialog(
            context,
            text: "Status: ",
            content: widget.order.status.name,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(1)),
            child: WidgetTextRich_Dialog(
              context,
              text: "Price: ",
              content: "${widget.order.totalOrderPrice} Da",
            ),
          ),
          SizedBox(height: context.heightPct(2)),
          _canDelete
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Container(
                          height: context.heightPct(7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDE6C8),
                            border: Border.all(
                              color: ColorApp_Icon_border.bottonbrown,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Text(
                            "close",
                            style: TextStyle(
                              color: ColorApp_Text.textbrown,
                              fontSize: context.heightPct(2.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.heightPct(2)),
                    Expanded(
                      child: MaterialButton(
                        onPressed: (!_canDelete || _isDeleting)
                            ? null
                            : _delete,
                        child: Container(
                          height: context.heightPct(7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: _isDeleting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "Cancel order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.heightPct(2.2),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

Dialog cancelOrderConfirmDialog(
  BuildContext context, {
  required Order_Model order,
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: _CancelOrderConfirmContent(order: order),
  );
}

class _CancelOrderConfirmContent extends StatefulWidget {
  final Order_Model order;
  const _CancelOrderConfirmContent({required this.order});

  @override
  State<_CancelOrderConfirmContent> createState() =>
      _CancelOrderConfirmContentState();
}

class _CancelOrderConfirmContentState
    extends State<_CancelOrderConfirmContent> {
  bool _isDeleting = false;

  bool get _canDelete => widget.order.status.state == 'waiting';

  Future<void> _delete() async {
    if (!_canDelete || _isDeleting) return;
    setState(() => _isDeleting = true);
    final success = await Provider.of<OrderProvider>(
      context,
      listen: false,
    ).deleteOrder(widget.order.orderId);
    if (!mounted) return;
    setState(() => _isDeleting = false);
    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to delete the order, it may have already been accepted by the restaurant',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Cancel order",
                style: TextStyle(
                  fontSize: context.heightPct(3),
                  fontFamily: "InterBold",
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(3)),
            child: Center(
              child: Text(
                _canDelete
                    ? "Do you want to cancel this order?"
                    : "Cannot cancel the order, it has already been accepted by the restaurant",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.heightPct(2),
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
                  onPressed: _delete,
                  name: _isDeleting ? "..." : "delete",
                  color: (!_canDelete || _isDeleting)
                      ? Colors.grey
                      : Colors.redAccent,
                ),
              ),
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: () => Navigator.of(context).pop(),
                  name: "cancel",
                  color: ColorApp_Botton.bottonOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
