import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/blacklist/blacklist_Provider.dart';
import 'package:app_owner/view/cart/widget/showDialog/show_card_dialg.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blacklist_Page extends StatelessWidget {
  const Blacklist_Page({super.key});

  @override
  Widget build(BuildContext context) {
    final blacklistProvider = Provider.of<BlacklistProvider>(context);

    return Scaffold(
      appBar: Widget_appBar(context, title: 'black list'),
      body: blacklistProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : blacklistProvider.blocked.isEmpty
          ? Center(
              child: Text(
                "There are currently no customers banned",
                style: TextStyle(
                  fontSize: context.heightPct(2),
                  color: ColorApp_Text.textbrown,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(context.heightPct(2)),
              itemCount: blacklistProvider.blocked.length,
              itemBuilder: (context, index) {
                final client = blacklistProvider.blocked[index];
                final bool isNetwork = client.image.startsWith('http');

                return InkWell(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => _costumAlertDialog(
                        context,
                        onPressedcancel: () => Navigator.pop(ctx, false),
                        onPressedUnblock: () => Navigator.pop(ctx, true),
                      ),
                    );
                    if (confirm == true) {
                      await blacklistProvider.unblock(client.uID);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(1),
                      horizontal: context.heightPct(1),
                    ),
                    child: Container(
                      height: context.heightPct(9),
                      width: context.widthPct(80),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 241, 227),
                        border: Border.all(
                          color: ColorApp_Icon_border.bottonbrown,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: context.heightPct(0.5),
                              right: context.heightPct(2),
                            ),
                            child: Container(
                              height: context.heightPct(7.5),
                              width: context.heightPct(7.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorApp_Icon_border.bottonbrown,
                                ),
                                image: DecorationImage(
                                  image: isNetwork
                                      ? NetworkImage(client.image)
                                            as ImageProvider
                                      : AssetImage(client.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.heightPct(1),
                                top: context.heightPct(0.5),
                                bottom: context.heightPct(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    client.name,
                                    style: TextStyle(
                                      fontFamily: "InterBold",
                                      fontSize: context.heightPct(2),
                                    ),
                                  ),
                                  Text(
                                    client.number,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: context.heightPct(1.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

Dialog _costumAlertDialog(
  BuildContext context, {
  required VoidCallback onPressedUnblock,
  required VoidCallback onPressedcancel,
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
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
                "Unblock",
                style: TextStyle(
                  fontSize: context.heightPct(3),
                  fontFamily: "InterBold",
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(3)),
            child: Center(
              child: Text(
                "do you want unBlock this person",
                style: TextStyle(
                  fontSize: context.heightPct(2),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPressedUnblock,
                  name: "unBlock",
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPressedcancel,
                  name: "cancel",
                  color: ColorApp_Botton.bottonOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
