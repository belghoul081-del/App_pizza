import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:app_owner/firebase/firestore/service/service_supplements.dart';
import 'package:app_owner/firebase_options.dart';
import 'package:app_owner/firebase/auth/auth_provider.dart';
import 'package:app_owner/provider/blacklist/blacklist_Provider.dart';
import 'package:app_owner/provider/cart/cart_Provider.dart';
import 'package:app_owner/provider/cart/sepliment_Provider.dart';
import 'package:app_owner/provider/chat/chat_Provider.dart';
import 'package:app_owner/provider/clients_Provider.dart';
import 'package:app_owner/provider/event/time.dart';
import 'package:app_owner/provider/internet/connectivity_provider.dart';
import 'package:app_owner/provider/internet/connectivityhandler.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:app_owner/provider/product/product_Provider.dart';
import 'package:app_owner/provider/announcement/announce_provider.dart';
import 'package:app_owner/service/notification_service.dart';
import 'package:app_owner/view/cart/cart_view.dart';
import 'package:app_owner/view/chat/messageGeneral.dart';
import 'package:app_owner/view/event/notification_view.dart';
import 'package:app_owner/view/interne_c.dart';
import 'package:app_owner/view/profile/account_view.dart';
import 'package:app_owner/view/settings/settings_view.dart';
import 'package:app_owner/view/start/choose_L_R_view.dart';
import 'package:app_owner/view/start/welcome_view.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/view/home/home_view.dart';
import 'package:app_owner/view/start/loading_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: const AndroidDebugProvider(),
  );

  await SupplementService.initSupplements();
  await NotificationService().init();
  NotificationService().listenToIncomingChats();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GetdataProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => BlacklistProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementProvider()),
        ChangeNotifierProvider(create: (_) => Time_Calculate()),
        ChangeNotifierProvider(create: (_) => ClientsProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,

        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ConnectivityHandler(child: child!);
        },
        theme: ThemeData(
          fontFamily: "Inter",
          appBarTheme: AppBarTheme(
            backgroundColor: ColorApp_Background.appbarecolor,
          ),
          scaffoldBackgroundColor: ColorApp_Background.backgroundcolor,
        ),
        home: Loading_Page(),
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

          /// setting
          "Settings": (context) => const Settings_Page(),
          '/NoInternet': (context) => const InterneC(),
        },
      ),
    );
  }
}
