
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class notif_op_cl_store extends StatelessWidget {
  const notif_op_cl_store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.heightPct(2),
        vertical: context.heightPct(1),
      ),
      child: Container(
        height: context.heightPct(10),
        decoration: BoxDecoration(
          color: ColorApp_Background.appbarecolor,
          border: Border.all(
            color: ColorApp_Icon_border.bottonbrown,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Marquee(
                  text:
                      "The shop is currently closed. It will open once you toggle the button.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorApp_Text.textbrown,
                  ),
                  scrollAxis: Axis
                      .horizontal,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  blankSpace:
                      75.0,
                  velocity:
                      40.0,
                  pauseAfterRound: Duration(
                    seconds: 2,
                  ), 
                  startPadding:
                      10.0, 
                  accelerationDuration: Duration(
                    seconds: 1,
                  ), 
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(
                    milliseconds: 500,
                  ),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.door_back_door,
                    color: ColorApp_Icon_border
                        .bottonbrown,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 30,
                      color: ColorApp_Icon_border
                          .bottonbrown,
                    ),
                  ),
                  const Icon(
                    Icons.meeting_room,
                    color: ColorApp_Botton.bottonOrange,
                    size: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
