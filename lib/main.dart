import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_multitext.dart';
import 'package:pawndr/Utils/AppRoutes.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}
ColorConfig colors= ColorConfig();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return DoubleBack(
      message: "Press back again to close",
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pawndr',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            canvasColor: Colors.transparent,
            dialogTheme: DialogTheme(
                backgroundColor: Colors.grey[200],
                contentTextStyle: textStyle,
                titleTextStyle: textStyle)),
         // home: SplashScreen1(),
        getPages: AppRoutes.routes,
        initialRoute: '/splash',
        builder: EasyLoading.init(),
       // initialBinding: UserBinding(),
      ),
    );
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {await Firebase.initializeApp();}
