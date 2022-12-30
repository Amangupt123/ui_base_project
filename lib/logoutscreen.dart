import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ui_base_project/alltextfield/textfield.dart';
import 'package:ui_base_project/controller/logincontroller.dart';
import 'package:ui_base_project/signuppage.dart';
import 'package:ui_base_project/validator.dart';

class Logout extends StatelessWidget {
  final AuthController login = Get.put(AuthController());
  Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text("Logout"),
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.only(right: 18.0),
          //     child: InkWell(
          //       onTap: () {
          //         login.signOut();
          //       },
          //       child: Image.asset(
          //         "assets/deleteicon.png",
          //         height: 30,
          //         width: 30,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Center(
            child: InkWell(
          child: greenContainer(buttonName: "Logout"),
          onTap: () {
            login.signOut();
          },
        )),
      ),
    );
  }
}
