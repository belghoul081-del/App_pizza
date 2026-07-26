import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/auth/auth_provider.dart';
import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:app_owner/models/admin/admin_model.dart';
import 'package:app_owner/view/profile/widget/widget_clipper.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetdataProvider>(context, listen: false).LoadData_Admin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_appBar(context, title: 'account'),
      body: Consumer2<AuthProvider, GetdataProvider>(
        builder: (context, authProvider, dataProvider, child) {
          if (dataProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final Admin_Model adminInf = dataProvider.admin.isNotEmpty
              ? dataProvider.admin.first
              : Admin_Model(name: "No data", number: "-");

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
                    adminInf: adminInf,
                    onPressed: authProvider.isLoading
                        ? () {}
                        : () async {
                            bool success = await authProvider.logout();

                            if (success && mounted) {
                              Provider.of<GetdataProvider>(
                                context,
                                listen: false,
                              ).clearAdminData();

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "Loading",
                                (route) => false,
                              );
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
                  child: Container(
                    height: context.heightPct(25),
                    width: context.heightPct(25),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorApp_Icon_border.bottonbrown,
                      ),
                      image: DecorationImage(
                        image:
                            adminInf.image.startsWith('http://') ||
                                adminInf.image.startsWith('https://')
                            ? NetworkImage(adminInf.image) as ImageProvider
                            : AssetImage(adminInf.image),
                        fit: BoxFit.cover,
                      ),
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
