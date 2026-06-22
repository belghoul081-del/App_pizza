import 'package:app_pizza_owner/provider/cart/cart_Provider.dart';
import 'package:app_pizza_owner/provider/cart/sepliment_Provider.dart';
import 'package:app_pizza_owner/view/cart/cart_view.dart';
import 'package:app_pizza_owner/view/chat/message.dart';
import 'package:app_pizza_owner/view/event/notification_view.dart';
import 'package:app_pizza_owner/view/profile/account_view.dart';
import 'package:app_pizza_owner/view/start/choose_L_R_view.dart';
import 'package:app_pizza_owner/view/start/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/view/home/home_view.dart';
import 'package:app_pizza_owner/view/start/loading_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SeplimentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
          appBarTheme: AppBarTheme(
            backgroundColor: ColorApp_Background.appbarecolor,
          ),
          scaffoldBackgroundColor: ColorApp_Background.backgroundcolor,
        ),
        home: Home_Page(),
        routes: {
          /// home page :
          "Home": (context) => Home_Page(),

          /// stare pages :
          "Loading": (context) => Loading_Page(),
          "Welcome": (context) => Welcome_Page(),
          "Welcome_chose": (context) => Welcome_chose_L_or_R(),

          /// chat page :
          "Chat": (context) => Chat_page(),

          /// cart page :
          "Cart": (context) => Order_Page(),

          /// profile page :
          "Profile": (context) => Profile_Page(),

          /// notification
          "Notification": (context) => Notification_Page(),
        },
      ),
    );
  }
}
