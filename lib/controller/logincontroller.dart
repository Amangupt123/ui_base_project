import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ui_base_project/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_base_project/signinpage.dart';
import 'package:ui_base_project/signuppage.dart';
import 'package:ui_base_project/validator.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dropdownController = TextEditingController();
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  final auth = FirebaseAuth.instance;
  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxString? selectedValue;
  DateTime selectedDate = DateTime.now();
  DateTime userDateOfBirth = DateTime.now();
  Future<void> signOut() async {
    try {
      launchProgress();

      await FirebaseAuth.instance.signOut();

      emailController.clear();
      passwordController.clear();
      disposeProgress();

      Get.off(SignInScreen());
    } on FirebaseAuthException catch (e) {
      return e.message.toString().toast();
    }
  }
}
