import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ui_base_project/controller/logincontroller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_base_project/model/usermodel.dart';
import 'package:ui_base_project/signinpage.dart';
import 'package:ui_base_project/signuppage.dart';

import 'main.dart';
import 'package:ui_base_project/validator.dart';

extension Utility on String {
  toast() => Fluttertoast.showToast(msg: this, gravity: ToastGravity.CENTER, backgroundColor: Color(0xff505050), toastLength: Toast.LENGTH_SHORT);
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Phone number';
  }

  return null;
}

disposeProgress() {
  Get.back();
}

customDialog({
  bool barrierDismissible = true,
  var isLoader = false,
  Widget widget = const Text('Pass sub widgets'),
}) async {
  var result = await Get.dialog(
      isLoader
          ? widget
          : Align(
              alignment: Alignment.center,
              child: widget,
            ),
      barrierDismissible: barrierDismissible);
  if (result != null) return result;
}

launchProgress({
  String message = 'Processing..',
}) {
  customDialog(
      isLoader: true,
      barrierDismissible: false,
      widget: const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
        //   backgroundColor: Color(0xffDBB77C),
      )));
}

bool checkValidEmail(String email) {
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  return emailValid;
}

bool isAdult2(DateTime birthDate) {
  DateTime today = DateTime.now();
  DateTime adultDate = DateTime(birthDate.year + 18, birthDate.month, birthDate.day);
  return adultDate.isBefore(today);
}

// email field validator
String? emailValidator(String? value) {
  final RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty) {
    return 'Please enter email';
  }
  if (!emailValid.hasMatch(value)) {
    return "Please enter valid email";
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  }
  if (value.length < 8) {
    return 'At least 8 characters required';
  }
  if (!value.contains(RegExp(r"[a-z]")) || !value.contains(RegExp(r"[A-Z]"))) {
    return "your password must contain  a small and capital letter";
  }
  if (!value.contains(RegExp(r"[0-9]"))) {
    return "your password must contain number";
  }

  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return "your password must contain a special character";
  }
  return null;
}

checkValidation() async {
  final AuthController login = Get.find();

  if (login.signinFormKey.currentState!.validate()) {
    if (login.emailController.text.isEmpty) {
      "Please enter email".toast();
      return;
    }

    if (!checkValidEmail(login.emailController.text)) {
      "Please enter valid email".toast();
      return;
    }

    if (login.nameController.text.isEmpty) {
      "Please enter name".toast();
      return;
    }
    if (login.dobController.text.isEmpty) {
      "Please select date of birth".toast();
      return;
    }
    if (!isAdult2(login.userDateOfBirth)) {
      "You should be 18 years old to register".toast();
      return;
    }

    if (login.passwordController.text.isEmpty) {
      "Please enter your password".toast();
      return;
    }
    if (login.confirmController.text.isEmpty) {
      "Please enter confirm password".toast();
      return;
    }
    if (login.passwordController.text != login.confirmController.text) {
      "Passwords does not match".toast();
      return;
    }
    launchProgress();

    var snapshot = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: login.emailController.text).get();
    disposeProgress();
    if (snapshot.docs.isNotEmpty && snapshot.docs[0].exists) {
      "This email id already exists".toast();
      return;
    }
    launchProgress();
    ProfileModel profileModel = ProfileModel(email: login.emailController.text, name: login.nameController.text, dateofBirth: login.dobController.text);

    final user = FirebaseAuth.instance.createUserWithEmailAndPassword(email: login.emailController.text, password: login.passwordController.text);
    print(user);

    // login.profileModel.value = profileModel;

    await FirebaseFirestore.instance.collection("users").doc().set(profileModel.toJson());
  }

  disposeProgress();
  login.confirmController.clear();
  login.dobController.clear();
  login.passwordController.clear();
  login.emailController.clear();
  login.nameController.clear();

  Get.off(SignInScreen());
}
