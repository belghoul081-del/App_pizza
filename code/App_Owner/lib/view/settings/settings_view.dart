import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/auth/auth_provider.dart';
import 'package:app_owner/firebase/firestore/service/admin_service.dart';
import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:app_owner/view/settings/privacy_policy_view.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings_Page extends StatefulWidget {
  const Settings_Page({super.key});

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}

class _Settings_PageState extends State<Settings_Page> {
  final AdminFirestoreService _adminService = AdminFirestoreService();
  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _numbersFormKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  late TextEditingController _numberController;
  late TextEditingController _number2Controller;

  bool _isSavingName = false;
  bool _isSavingPassword = false;
  bool _isSavingNumbers = false;

  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<GetdataProvider>(context, listen: false);
    final admin = dataProvider.admin.isNotEmpty
        ? dataProvider.admin.first
        : null;
    _nameController = TextEditingController(text: admin?.name ?? '');
    _numberController = TextEditingController(text: admin?.number ?? '');
    _number2Controller = TextEditingController(text: admin?.number2 ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _numberController.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    if (!_nameFormKey.currentState!.validate()) return;
    setState(() => _isSavingName = true);
    try {
      await _adminService.updateAdminName(_nameController.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The restaurant name has been updated")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Update failed: $e")));
    } finally {
      if (mounted) setState(() => _isSavingName = false);
    }
  }

  Future<void> _saveNumbers() async {
    if (!_numbersFormKey.currentState!.validate()) return;
    setState(() => _isSavingNumbers = true);
    try {
      final newNumber = _numberController.text.trim();
      final newNumber2 = _number2Controller.text.trim();
      await _adminService.updateAdminNumbers(
        number: newNumber,
        number2: newNumber2,
      );
      if (!mounted) return;
      Provider.of<GetdataProvider>(
        context,
        listen: false,
      ).updateLocalNumbers(number: newNumber, number2: newNumber2);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The phone number has been updated")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Update failed: $e")));
    } finally {
      if (mounted) setState(() => _isSavingNumbers = false);
    }
  }

  Future<void> _savePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;
    setState(() => _isSavingPassword = true);

    final error = await Provider.of<AuthProvider>(context, listen: false)
        .changePassword(
          email: _emailController.text.trim(),
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
              "Restaurant Name",
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
              "Contact numbers",
              style: TextStyle(
                fontSize: context.heightPct(2.5),
                fontFamily: "InterBold",
                color: ColorApp_Text.textbrown,
              ),
            ),
            SizedBox(height: context.heightPct(1)),
            Form(
              key: _numbersFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _numberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "numbers 1",
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? "Enter the first number"
                        : null,
                  ),
                  SizedBox(height: context.heightPct(1.5)),
                  TextFormField(
                    controller: _number2Controller,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "numbers 2",
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? "Enter the second number"
                        : null,
                  ),
                  SizedBox(height: context.heightPct(2)),
                  SizedBox(
                    width: double.infinity,
                    child: Widget_botton(
                      context,
                      text: _isSavingNumbers
                          ? "Saving..."
                          : "Save the two numbers",
                      onPressed: _isSavingNumbers ? () {} : _saveNumbers,
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
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Your email (to confirm identity)",
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? "Enter email " : null,
                  ),
                  SizedBox(height: context.heightPct(1.5)),
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
                      if (v.length < 6) return "It must be at least 6 characters long";
                      return null;
                    },
                  ),
                  SizedBox(height: context.heightPct(2)),
                  SizedBox(
                    width: double.infinity,
                    child: Widget_botton(
                      context,
                      text: _isSavingPassword ? "Saving..." : "Change Password",
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

            // رابط سياسة الخصوصية أسفل صفحة الإعدادات بالكامل
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
