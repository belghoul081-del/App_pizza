import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/firebase/auth/auth_provider.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/provider/client/client_Provider.dart';
import 'package:app_pizza_client/view/profile/widget/widget_clipper.dart';
import 'package:app_pizza_client/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_client/widget/custom/custom_takeImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientProvider>(context, listen: false).loadClient();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_appBar(context, title: 'account'),
      body: Consumer2<AuthProvider, ClientProvider>(
        builder: (context, authProvider, clientProvider, child) {
          if (clientProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final Client_Model clientInf = clientProvider.client;
          final bool isNetwork =
              clientInf.image.startsWith('http://') ||
              clientInf.image.startsWith('https://');

          return Padding(
            padding: EdgeInsets.only(
              left: context.heightPct(2),
              right: context.heightPct(2),
              bottom: context.heightPct(4),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                ///container
                Padding(
                  padding: EdgeInsets.only(top: context.heightPct(17)),
                  child: widget_ClipPath(
                    context,
                    clientInf: clientInf,
                    onPressed: authProvider.isLoading
                        ? () {}
                        : () async {
                            bool success = await authProvider.logout();

                            if (success && mounted) {
                                        Provider.of<ClientProvider>(context, listen: false).clearClientData();

                              Navigator.of(
                                context,
                              ).pushNamedAndRemoveUntil("Loading", (route) => false,);
                            } else if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Logout failed. Please check your details.",
                                  ),
                                ),
                              );
                            }
                          },
                  ),
                ),

                ///image
                Padding(
                  padding: EdgeInsets.only(top: context.heightPct(4.5)),
                  child: GestureDetector(
                    onTap: () => showImageSourcePickerStyled(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: context.heightPct(25),
                          width: context.heightPct(25),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorApp_Icon_border.bottonbrown,
                            ),
                            image: DecorationImage(
                              image: isNetwork
                                  ? NetworkImage(clientInf.image)
                                        as ImageProvider
                                  : AssetImage(clientInf.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (clientProvider.isUpdatingImage)
                          Container(
                            height: context.heightPct(25),
                            width: context.heightPct(25),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black38,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        else
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorApp_Botton.bottonOrange,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
