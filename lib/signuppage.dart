import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ui_base_project/alltextfield/textfield.dart';
import 'package:ui_base_project/controller/logincontroller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ui_base_project/validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController login = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: login.signinFormKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(height: 20),
                  const Textinput(textname: "Join Us", fontWeight: FontWeight.w600, fontsize: 26),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, top: 0, bottom: 8),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: const [Text("SignUp Now", style: TextStyle(fontSize: 18))])),
                  const SizedBox(height: 20),
                  const Textinput(textname: "Email", fontWeight: FontWeight.w600),
                  textfield(hintText: "Enter Your Email", controller: login.emailController, validator: emailValidator),
                  const Textinput(textname: "Name", fontWeight: FontWeight.w600),
                  textfield(hintText: "Enter Your Name", controller: login.nameController),
                  const Textinput(textname: "Date of Birth", fontWeight: FontWeight.w600),
                  textfield(
                      hintText: "Enter Your DOB",
                      controller: login.dobController,
                      image: InkWell(child: SvgPicture.asset("assets/calender.svg", fit: BoxFit.scaleDown), onTap: (() => selectDate(context)))),
                  const Textinput(textname: "Password", fontWeight: FontWeight.w600),
                  Obx(() => textfield(
                      hintText: "Enter Your Password",
                      validator: passwordValidator,
                      controller: login.passwordController,
                      isObscure: login.isObscure2.value,
                      image: ObsecureIcon(isVisible: login.isObscure2.value, onTap: () => login.isObscure2.value = !login.isObscure2.value))),
                  const Textinput(textname: "Confirm Password", fontWeight: FontWeight.w600),
                  Obx(() => textfield(
                      hintText: "Enter Your Confirm Password",
                      controller: login.confirmController,
                      isObscure: login.isObscure1.value,
                      image: ObsecureIcon(isVisible: login.isObscure1.value, onTap: () => login.isObscure1.value = !login.isObscure1.value))),
                  const SizedBox(height: 15),
                  InkWell(
                      onTap: () async {
                        checkValidation();
                      },
                      child: const greenContainer(buttonName: "Sign Up")),
                  const SizedBox(height: 15),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Textinput(textname: "You have an account?", fontsize: 16),
                    InkWell(
                        onTap: (() => Get.back()), child: const Textinput(textname: "Sign In", fontsize: 16, color: Colors.green, fontWeight: FontWeight.w600))
                  ])
                ]))));
  }
}
