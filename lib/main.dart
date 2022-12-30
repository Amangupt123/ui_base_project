import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_base_project/alltextfield/textfield.dart';
import 'package:ui_base_project/controller/logincontroller.dart';
import 'package:ui_base_project/signinpage.dart';
import 'package:ui_base_project/signuppage.dart';
import 'package:ui_base_project/validator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: SignInScreen());
  }
}
