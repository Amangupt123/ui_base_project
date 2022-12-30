import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ui_base_project/alltextfield/textfield.dart';
import 'package:ui_base_project/controller/logincontroller.dart';
import 'package:ui_base_project/logoutscreen.dart';
import 'package:ui_base_project/signuppage.dart';
import 'package:ui_base_project/validator.dart';

class SignInScreen extends StatelessWidget {
  final AuthController login = Get.put(AuthController());
  final auth = FirebaseAuth.instance;
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(
          "Login Page",
        ),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 10),
        const Textinput(textname: "Sign In", fontWeight: FontWeight.w600, fontsize: 26),
        const Textinput(textname: "Sign in now to cheer up you mood.", fontsize: 18),
        const SizedBox(height: 30),
        const Textinput(textname: "Email", fontWeight: FontWeight.w600),
        textfield(hintText: "Enter Your Email", controller: login.emailController, validator: emailValidator),
        const Textinput(textname: "Password", fontWeight: FontWeight.w600),
        Obx(() => textfield(
            hintText: "Enter Your Password",
            controller: login.passwordController,
            isObscure: login.isObscure.value,
            validator: passwordValidator,
            image: ObsecureIcon(isVisible: login.isObscure.value, onTap: () => login.isObscure.value = !login.isObscure.value))),
        const SizedBox(height: 15),
        InkWell(
            onTap: (() async {
              if (login.emailController.text.isEmpty) {
                return "Please enter your email id".toast();
              } else if (login.passwordController.text.isEmpty) {
                return "Please enter your password".toast();
              }

              try {
                launchProgress();
                final response = await auth.signInWithEmailAndPassword(email: login.emailController.text, password: login.passwordController.text);
                print(response.user?.uid);

                Get.off(Logout());
              } on FirebaseAuthException catch (e) {
                e.message.toString().toast();
                log(e.toString());
                disposeProgress();
              }
            }),
            child: greenContainer(buttonName: "Sign In")),
        const SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Textinput(textname: "Don’t have an account?", fontsize: 16),
          InkWell(onTap: (() => Get.to(SignUpScreen())), child: Textinput(textname: "Sign Up", fontsize: 16, color: Colors.green, fontWeight: FontWeight.w600))
        ])
      ]),
    ));
  }
}
