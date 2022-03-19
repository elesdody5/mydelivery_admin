import 'package:core/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydelivery_admin/pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'language/messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Delivery Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "ELMessiri",
        primaryColor: const Color(0xFFFFe477),
        primaryColorLight: const Color(0xffffe061),
        primaryIconTheme: const IconThemeData(color: Color(0xFFEF6F6F)),
        cardColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(10)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFFFe477))),
        ),
        appBarTheme: const AppBarTheme(
            color: Color(0xFFFFe477), foregroundColor: Colors.black),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xfff45b55)),
          bodyText2: TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.black),
        ),
      ),
      translations: Messages(),
      // your translations
      locale: const Locale("ar"),
      // translations will be displayed in that locale
      fallbackLocale: const Locale('ar'),
      initialRoute: homeScreen,
      getPages: appPages,
    );
  }
}
