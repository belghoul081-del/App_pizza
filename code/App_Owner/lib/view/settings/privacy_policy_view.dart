import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy_Page extends StatelessWidget {
  const PrivacyPolicy_Page({super.key});

  static const String companyName = "Infinity Pizza";
  static const String Appname = "Noveno studio";

  static const String releaseDate = "2026";

  static const List<String> permissions = [
    "الكاميرا: لالتقاط صور المنتجات وصورة الملف الشخصي.",
    "معرض الصور: لاختيار صور من الجهاز.",
    "الموقع الجغرافي (GPS): لتحديد موقع التوصيل بدقة.",
    "الإشعارات: لتنبيهك بحالة طلبك والرسائل الجديدة.",
    "الإنترنت: للاتصال بالخادم وعرض وإرسال البيانات.",
  ];

  // ⚠️ نص إخلاء المسؤولية القانونية
  static const String disclaimerText = "زعمة غادي تقرا هذي , مشكيتش";
  // ✅ البنود الجديدة التي طلبتها مدمجة في نص السياسة
  static const String policyText =
      "1. تخزين البيانات وحذف الحساب:\n"
      "تتم معالجة بياناتك وتخزينها بأمان تام (عبر قواعد بيانات Firebase). حالياً، لا يدعم التطبيق ميزة الحذف التلقائي للحساب من واجهة المستخدم. إذا كنت ترغب في حذف حسابك وإزالة بياناتك بالكامل، يجب عليك التواصل المباشر مع مالك التطبيق ليتم حذف بياناتك يدوياً من النظام.\n\n"
      "2. سياسة الاستخدام والطلبات المزيفة:\n"
      "نأخذ التلاعب وجدية الطلبات على محمل الجد. يُحظر تماماً القيام بأي سلوك غير أخلاقي مثل إرسال طلبات مزيفة أو تعمد عدم استلام الطلبات بعد تجهيزها. في حال ثبوت ذلك، يحتفظ '$companyName' بالحق الكامل في اتخاذ كافة الإجراءات القانونية الصارمة، ورفع دعاوى قضائية ضد المخالف لتعويض الخسائر المادية والمعنوية الناتجة عن هذا التلاعب.\n\n"
      "3. التواصل والدعم والمشاكل:\n"
      "عيط لحنفية ";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: Widget_appBar(context, title: 'Privacy Policy'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(context.heightPct(2.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // قسم الشعارات (شعار الشركة وشعار المحل)
              // ==========================================
              Image.asset(
                "assets/logo_privet.png",
                height: context.heightPct(10),
              ),
      
              SizedBox(height: context.heightPct(1)),
              Divider(color: ColorApp_Icon_border.bottonbrown),
              SizedBox(height: context.heightPct(2)),
              Text(
                "مراحش تقراهم علابالي",
                style: TextStyle(
                  fontSize: context.heightPct(3.2),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
              SizedBox(height: context.heightPct(1)),
              Divider(color: ColorApp_Icon_border.bottonbrown),
              SizedBox(height: context.heightPct(2)),
      
              // ==========================================
              // العنوان ومعلومات الإصدار
              // ==========================================
              Text(
                "سياسة الخصوصية وإخلاء المسؤولية",
                style: TextStyle(
                  fontSize: context.heightPct(3.2),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
              SizedBox(height: context.heightPct(0.5)),
              Text(
                "© $releaseDate $Appname. جميع الحقوق محفوظة.",
                style: TextStyle(
                  fontSize: context.heightPct(1.8),
                  color: Colors.grey.shade700,
                ),
              ),
      
              SizedBox(height: context.heightPct(3)),
      
              // ==========================================
              // إخلاء المسؤولية (Disclaimer)
              // ==========================================
              Container(
                padding: EdgeInsets.all(context.heightPct(1.5)),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red.shade700,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "إخلاء مسؤولية هام",
                          style: TextStyle(
                            fontSize: context.heightPct(2.2),
                            fontFamily: "InterBold",
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(1)),
                    Text(
                      disclaimerText,
                      style: TextStyle(
                        fontSize: context.heightPct(1.8),
                        color: Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
      
              SizedBox(height: context.heightPct(3)),
      
              // ==========================================
              // الصلاحيات
              // ==========================================
              Text(
                "الصلاحيات التي يحصل عليها التطبيق",
                style: TextStyle(
                  fontSize: context.heightPct(2.5),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
              SizedBox(height: context.heightPct(1)),
              ...permissions.map(
                (p) => Padding(
                  padding: EdgeInsets.symmetric(vertical: context.heightPct(0.5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "•  ",
                        style: TextStyle(
                          color: ColorApp_Text.textbrown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          p,
                          style: TextStyle(
                            fontSize: context.heightPct(1.9),
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              SizedBox(height: context.heightPct(3)),
              Divider(color: ColorApp_Icon_border.bottonbrown),
              SizedBox(height: context.heightPct(2)),
      
              // ==========================================
              // نص السياسة التفصيلي (الشروط الجديدة)
              // ==========================================
              Text(
                "شروط الاستخدام والسياسة",
                style: TextStyle(
                  fontSize: context.heightPct(2.5),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
              SizedBox(height: context.heightPct(1)),
              Container(
                padding: EdgeInsets.all(context.heightPct(1.5)),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  policyText,
                  style: TextStyle(
                    fontSize: context.heightPct(1.9),
                    color: Colors.grey.shade800,
                    height: 1.6, // تباعد الأسطر لسهولة القراءة
                  ),
                ),
              ),
              SizedBox(height: context.heightPct(4)),
            ],
          ),
        ),
      ),
    );
  }
}
