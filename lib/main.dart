import 'dart:io';

import 'package:finance_manager/common/CommonHttpOverrides.dart';
import 'package:finance_manager/controller/HomeNavigationController.dart';
import 'package:finance_manager/controller/AddScreenController.dart';
import 'package:finance_manager/controller/AuthInfoController.dart';
import 'package:finance_manager/controller/LoadingController.dart';
import 'package:finance_manager/controller/SignUpController.dart';
import 'package:finance_manager/controller/StatisticsItemController.dart';
import 'package:finance_manager/model/BalanceItemData.dart';
import 'package:finance_manager/screens/AddScreen.dart';
import 'package:finance_manager/screens/Home.dart';
import 'package:finance_manager/screens/Login.dart';
import 'package:finance_manager/screens/SignUp.dart';
import 'package:finance_manager/widgets/BottomNavigationBar.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';
import 'screens/Statistics.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(BalanceItemDataAdapter());
  var box = await Hive.openBox<BalanceItemData>('balanceItemData');
  HttpOverrides.global = CommonHttpOverrides();
  Get.put(AuthInfoController());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.teal[700],
    )
  );
  Logger.init(
    true,
    isShowNavigation: false,
    isShowTime: false,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Duration(
        milliseconds: 350
      ),
      getPages: [
        GetPage(
            name: '/main',
            page: () => BottomNavigationView(),
            binding: BindingsBuilder(() {
              Get.put(HomeNavigationController());
            },)
        ),
        GetPage(
            name: '/signup',
            page: () => SignUp(),
            binding: BindingsBuilder(() {
              Get.put(SignUpController());
            },)
        ),
        GetPage(
            name: '/login',
            page: () => Login(),
        ),
        GetPage(
            name: '/addItem',
            page: () => AddScreen(),
            popGesture: true,
            binding: BindingsBuilder(() {
              Get.put(AddScreenController());
            },),
        ),
        GetPage(
            name: '/statistics',
            page: () => Statistics(),
        ),
        GetPage(
            name: '/home',
            page: () => Home(),
        )
      ],
      home: Splash(),
    );
  }
}

class Splash extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}
