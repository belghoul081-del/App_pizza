import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:app_owner/firebase/firestore/service/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchOpenORClose extends StatefulWidget {
  final bool isOpen;
  const SwitchOpenORClose({super.key, required this.isOpen});

  @override
  State<SwitchOpenORClose> createState() => _SwitchOpenORCloseState();
}

class _SwitchOpenORCloseState extends State<SwitchOpenORClose> {
  final AdminFirestoreService _service = AdminFirestoreService();
  late bool isOpened;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    isOpened = widget.isOpen;
  }

  @override
  void didUpdateWidget(covariant SwitchOpenORClose oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSaving && oldWidget.isOpen != widget.isOpen) {
      setState(() => isOpened = widget.isOpen);
    }
  }

  Future<void> _toggle(bool value) async {
    final previous = isOpened;
    setState(() {
      isOpened = value;
      _isSaving = true;
    });
    try {
      await _service.updateStoreStatus(value);
      if (mounted) {
        Provider.of<GetdataProvider>(
          context,
          listen: false,
        ).updateLocalStoreStatus(value);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isOpened = previous);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Store status update failed: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: context.heightPct(0.2),
      child: Switch(
        value: isOpened,
        onChanged: _isSaving ? null : _toggle,
        trackOutlineColor: WidgetStateProperty.all(
          ColorApp_Icon_border.bottonbrown,
        ),
        trackOutlineWidth: WidgetStateProperty.all(1),
        inactiveTrackColor: ColorApp_Background.appbarecolor,
        activeThumbColor: const Color.fromARGB(255, 253, 189, 100),

        thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(
              Icons.meeting_room,
              color: ColorApp_Icon_border.bottonbrown,
              size: 20,
            );
          }
          return const Icon(
            Icons.door_back_door,
            color: ColorApp_Background.appbarecolor,
            size: 20,
          );
        }),

        thumbColor: WidgetStateProperty.all(
          isOpened
              ? ColorApp_Botton.bottonOrange
              : ColorApp_Icon_border.bottonbrown,
        ),
      ),
    );
  }
}
