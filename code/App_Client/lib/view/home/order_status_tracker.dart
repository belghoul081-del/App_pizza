import 'package:app_pizza_client/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

enum OrderTrackStatus { waiting, cook, delivery, finish }

OrderTrackStatus orderTrackStatusFromState(String state) {
  switch (state.toLowerCase()) {
    case 'cook':
      return OrderTrackStatus.cook;
    case 'delivery':
      return OrderTrackStatus.delivery;
    case 'finish':
      return OrderTrackStatus.finish;
    case 'waiting':
    default:
      return OrderTrackStatus.waiting;
  }
}

class OrderStatusTracker extends StatefulWidget {
  final String status;
  final VoidCallback? onCancel;

  const OrderStatusTracker({super.key, required this.status, this.onCancel});

  @override
  State<OrderStatusTracker> createState() => _OrderStatusTrackerState();
}

class _OrderStatusTrackerState extends State<OrderStatusTracker>
    with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AnimationController _progressController;
  late Animation<double> _progressAnimation;

  final double _deliveryMaxProgress = 0.85;

  // ⏱️ مدة شريط التوصيل: عدّلها بين 5 و10 دقائق حسب رغبتك.
  static const Duration _deliveryDuration = Duration(minutes: 7);
  static const Duration _finishFillDuration = Duration(milliseconds: 500);

  // سماكة الإطار البني — يجب أن تطابق قيمة BorderSide بالأسفل تمامًا
  static const double _borderWidth = 2.5;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: _deliveryDuration,
    );

    _setupAnimations(orderTrackStatusFromState(widget.status));
  }

  @override
  void didUpdateWidget(covariant OrderStatusTracker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _setupAnimations(orderTrackStatusFromState(widget.status));
    }
  }

  void _setupAnimations(OrderTrackStatus state) {
    switch (state) {
      case OrderTrackStatus.waiting:
      case OrderTrackStatus.cook:
        _waveController.stop();
        _progressController.stop();
        _progressAnimation = Tween<double>(
          begin: 0.0,
          end: 0.0,
        ).animate(_progressController);
        break;

      case OrderTrackStatus.delivery:
        _waveController.repeat();

        // ✅ الإصلاح الأساسي: ضبط مدة الوصول إلى 85% صراحة، بدل ترك
        // المدة الافتراضية (100ms) الموروثة من initState.
        _progressController.duration = _deliveryDuration;

        _progressAnimation =
            Tween<double>(
              begin: _progressController.value > 0
                  ? _progressController.value
                  : 0.0,
              end: _deliveryMaxProgress,
            ).animate(
              CurvedAnimation(
                parent: _progressController,
                curve: Curves.linear,
              ),
            );
        // من نقطة البداية الحالية وليس من الصفر، حتى لا يعيد الشريط بدايته
        // إذا أعيد بناء الودجت أثناء التوصيل
        _progressController.forward(from: _progressController.value);
        break;

      case OrderTrackStatus.finish:
        _waveController.stop();
        _progressAnimation =
            Tween<double>(begin: _progressAnimation.value, end: 1.0).animate(
              CurvedAnimation(
                parent: _progressController,
                curve: Curves.easeOut,
              ),
            );
        _progressController.duration = _finishFillDuration;
        _progressController.forward(from: 0);
        break;
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = orderTrackStatusFromState(widget.status);

    return Row(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: Listenable.merge([_waveController, _progressController]),
            builder: (context, _) => _buildTrack(state),
          ),
        ),
        if (state == OrderTrackStatus.waiting) ...[
          const SizedBox(width: 10),
          _buildCancelButton(),
        ],
      ],
    );
  }

  Widget _buildTrack(OrderTrackStatus state) {
    const double height = 60;
    const Color trackBg = ColorApp_Background.appbarecolor;
    const Color fillColor = ColorApp_Botton.bottonOrange;
    const Color borderColor = ColorApp_Icon_border.bottonbrown;

    final double innerHeight = height - _borderWidth * 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double trackWidth = constraints.maxWidth;
        final double innerWidth = trackWidth - _borderWidth * 2;

        final double minFillWidth = innerHeight * 1.2;

        double currentProgress = _progressAnimation.value;
        double fillWidth = math.max(innerWidth * currentProgress, minFillWidth);

        // عند الانتهاء الكامل، يملأ العرض الداخلي بأكمله بدون أي فجوة
        if (state == OrderTrackStatus.finish && currentProgress >= 0.999) {
          fillWidth = innerWidth;
          currentProgress = 1.0;
        }

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: trackBg,
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(color: borderColor, width: _borderWidth),
          ),
          clipBehavior: Clip.antiAlias,
          // ✅ الحشوة تضمن أن الجزء البرتقالي لا يلمس شريط الإطار إطلاقًا،
          // فيبقى الإطار البني ظاهرًا دائمًا حتى فوق الجزء الممتلئ
          child: Padding(
            padding: const EdgeInsets.all(_borderWidth),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipPath(
                  clipper: WaveClipper(
                    progress: currentProgress,
                    wavePhase: _waveController.value * 2 * math.pi,
                    isActive: state == OrderTrackStatus.delivery,
                  ),
                  child: Container(
                    width: fillWidth,
                    height: innerHeight,
                    color: fillColor,
                  ),
                ),
                Positioned(
                  left: fillWidth - innerHeight + 4,
                  child: SizedBox(
                    width: innerHeight - 8,
                    height: innerHeight - 8,
                    child: Center(child: _getIconForState(state)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getIconForState(OrderTrackStatus state) {
    late final String assetPath;
    switch (state) {
      case OrderTrackStatus.waiting:
        assetPath = 'assets/icons/order/Icon_box.svg';
        break;
      case OrderTrackStatus.cook:
        assetPath = 'assets/icons/order/Icon_cook.svg';
        break;
      case OrderTrackStatus.delivery:
        assetPath = 'assets/icons/order/Icon_delivery.svg';
        break;
      case OrderTrackStatus.finish:
        assetPath = 'assets/icons/order/Icon_pizza.svg';
        break;
    }
    return SvgPicture.asset(
      assetPath,
      width: 30,
      height: 30,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }

  Widget _buildCancelButton() {
    return OutlinedButton(
      onPressed: widget.onCancel,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFB3261E),
        side: const BorderSide(color: Color(0xFFB3261E)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      child: const Text('cancel'),
    );
  }
}

/// كلاس مخصص لرسم حافة الجزء البرتقالي، مع زاوية يسرى دائرية مبنية
/// داخل الشكل نفسه (وليس معتمدة فقط على قص الحاوية الأم)
class WaveClipper extends CustomClipper<Path> {
  final double progress;
  final double wavePhase;
  final bool isActive;

  WaveClipper({
    required this.progress,
    required this.wavePhase,
    required this.isActive,
  });

  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;
    // نصف قطر الزاوية اليسرى الدائرية = نصف الارتفاع الداخلي
    final double r = math.min(height / 2, width / 2);

    Path path = Path();

    // عند الاكتمال الكامل: شكل حبة دواء (Stadium) مدوّر من الطرفين تمامًا
    if (progress >= 1.0) {
      return Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, width, height),
          Radius.circular(height / 2),
        ),
      );
    }

    // نبدأ بعد الزاوية اليسرى العلوية
    path.moveTo(r, 0);

    if (!isActive) {
      // خط مستقيم تمامًا في الحافة اليمنى (waiting / cook)
      path.lineTo(width, 0);
      path.lineTo(width, height);
    } else {
      // تموجات عضوية أثناء التوصيل فقط
      path.lineTo(width - 15, 0);
      path.quadraticBezierTo(
        width + 5 + math.sin(wavePhase) * 6,
        height * 0.25,
        width - 5,
        height * 0.5,
      );
      path.quadraticBezierTo(
        width - 15 + math.cos(wavePhase) * 6,
        height * 0.75,
        width - 5,
        height,
      );
    }

    path.lineTo(r, height);

    // الزاوية اليسرى: قوس نصف دائري كامل يعطي دائرية حقيقية للحافة اليسرى
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r), clockwise: true);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant WaveClipper oldClipper) {
    return oldClipper.wavePhase != wavePhase ||
        oldClipper.progress != progress ||
        oldClipper.isActive != isActive;
  }
}
