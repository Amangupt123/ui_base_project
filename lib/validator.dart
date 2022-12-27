import 'package:flutter/widgets.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ui_base_project/controller/logincontroller.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension Utility on String {
  toast() => Fluttertoast.showToast(msg: this, gravity: ToastGravity.CENTER, backgroundColor: Color(0xff505050), toastLength: Toast.LENGTH_SHORT);
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Phone number';
  }

  return null;
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

// password field validator
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
  }
}
