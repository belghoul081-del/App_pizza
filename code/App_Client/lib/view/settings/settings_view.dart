import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/firebase/auth/auth_provider.dart';
import 'package:app_pizza_client/provider/client/client_Provider.dart';
import 'package:app_pizza_client/view/settings/privacy_policy_view.dart';
import 'package:app_pizza_client/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_client/widget/custom/costum_botton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings_Page extends StatefulWidget {
  const Settings_Page({super.key});

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}

class _Settings_PageState extends State<Settings_Page> {
  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isSavingName = false;
  bool _isSavingPassword = false;

  @override
  void initState() {
    super.initState();
    final client = Provider.of<ClientProvider>(context, listen: false).client;
    _nameController = TextEditingController(text: client.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    if (!_nameFormKey.currentState!.validate()) return;
    setState(() => _isSavingName = true);

    final success = await Provider.of<ClientProvider>(
      context,
      listen: false,
    ).updateName(_nameController.text);

    if (!mounted) return;
    setState(() => _isSavingName = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "Name updated successfully" : "Failed to update name",
        ),
      ),
    );
  }

  Future<void> _savePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;
    setState(() => _isSavingPassword = true);

    final clientNumber = Provider.of<ClientProvider>(
      context,
      listen: false,
    ).client.number;

    final error = await Provider.of<AuthProvider>(context, listen: false)
        .changePassword(
          number: clientNumber,
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        );

    if (!mounted) return;
    setState(() => _isSavingPassword = false);

    if (error == null) {
      _currentPasswordController.clear();
      _newPasswordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password changed successfully")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_appBar(context, title: 'settings'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.heightPct(2.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(
                fontSize: context.heightPct(2.5),
                fontFamily: "InterBold",
                color: ColorApp_Text.textbrown,
              ),
            ),
            SizedBox(height: context.heightPct(1)),
            Form(
              key: _nameFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "your Name",
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? "Enter a name"
                          : null,
                    ),
                  ),
                  SizedBox(width: context.widthPct(2)),
                  Widget_botton(
                    context,
                    text: _isSavingName ? "..." : "save",
                    onPressed: _isSavingName ? () {} : _saveName,
                    height: 6,
                    width: 22,
                    backgroundColor: ColorApp_Botton.bottonOrange,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(4)),
            Divider(color: ColorApp_Icon_border.bottonbrown),
            SizedBox(height: context.heightPct(2)),

            Text(
              "Change password",
              style: TextStyle(
                fontSize: context.heightPct(2.5),
                fontFamily: "InterBold",
                color: ColorApp_Text.textbrown,
              ),
            ),
            SizedBox(height: context.heightPct(1)),
            Form(
              key: _passwordFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Current password",
                    ),
                    validator: (v) => (v == null || v.isEmpty)
                        ? "Enter your current password"
                        : null,
                  ),
                  SizedBox(height: context.heightPct(1.5)),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "The new password",
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Enter a new password";
                      if (v.length < 6)
                        return "It must be at least 6 characters long";
                      return null;
                    },
                  ),
                  SizedBox(height: context.heightPct(2)),
                  SizedBox(
                    width: double.infinity,
                    child: Widget_botton(
                      context,
                      text: _isSavingPassword ? "Saving..." : "Change password",
                      onPressed: _isSavingPassword ? () {} : _savePassword,
                      height: 7,
                      width: 100,
                      backgroundColor: ColorApp_Botton.bottonOrange,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.heightPct(4)),
            Divider(color: ColorApp_Icon_border.bottonbrown),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: ColorApp_Icon_border.bottonbrown,
              ),
              title: Text(
                "privacy policy",
                style: TextStyle(
                  fontSize: context.heightPct(2.2),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy_Page(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
