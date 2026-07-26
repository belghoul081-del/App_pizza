import 'package:app_pizza_client/firebase/auth/auth_provider.dart';
import 'package:app_pizza_client/firebase_options.dart';
import 'package:app_pizza_client/provider/admin/admin_provider.dart';
import 'package:app_pizza_client/provider/announcement/announce_provider.dart';
import 'package:app_pizza_client/provider/blacklist/blacklist_Provider.dart';
import 'package:app_pizza_client/provider/cart/cart_Provider.dart';
import 'package:app_pizza_client/provider/cart/sepliment_Provider.dart';
import 'package:app_pizza_client/provider/chat_watcher_Provider.dart';
import 'package:app_pizza_client/provider/client/client_Provider.dart';
import 'package:app_pizza_client/provider/internet/connectivity_provider.dart';
import 'package:app_pizza_client/provider/internet/connectivityhandler.dart';
import 'package:app_pizza_client/provider/order/order_Provider.dart';
import 'package:app_pizza_client/provider/product/product_Provider.dart';
import 'package:app_pizza_client/provider/event/time.dart';
import 'package:app_pizza_client/provider/product/suppliment_provider.dart';
import 'package:app_pizza_client/service/notification_service.dart';
import 'package:app_pizza_client/view/Home_Gate.dart';
import 'package:app_pizza_client/view/cart/cart_view.dart';
import 'package:app_pizza_client/view/chat/message.dart';
import 'package:app_pizza_client/view/event/notification_view.dart';
import 'package:app_pizza_client/view/profile/account_view.dart';
import 'package:app_pizza_client/view/start/choose_L_R_view.dart';
import 'package:app_pizza_client/view/start/welcome_view.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/view/start/loading_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: const AndroidDebugProvider(),
  );

  await NotificationService().init();

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
        ChangeNotifierProvider(create: (_) => SupplementSelectionProvider()),

        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => Time_Calculate()),
        ChangeNotifierProvider(create: (_) => ChatWatcherProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => BlacklistProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementProvider()),
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
          "Home": (context) => Home_Gate(),

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
