import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_base_project/controller/logincontroller.dart';

class textfield extends StatelessWidget {
  textfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.image,
    this.isObscure = false,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  Widget? image;
  final bool isObscure;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.height * 0.000),
        decoration: BoxDecoration(
            //  border: Border.all(color: const Color(0xffDDDDDD)),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF5F5F8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: isObscure,
                //textAlign: TextAlign.start,
                controller: controller,
                keyboardType: keyboardType,
                //  style: textFieldValueTextStyle,
                // style:const TextStyle(
                //   fontSize: 14,
                //   color: Color(0xff111A2C),
                //   fontWeight: FontWeight.w600
                //   // fontWeight: FontWeight.bold,
                // ) ,
                validator: validator,
                decoration: InputDecoration(
                  border: InputBorder.none, hintText: hintText, suffixIcon: image,

                  // hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Textinput extends StatelessWidget {
  const Textinput({super.key, required this.textname, this.color, this.fontWeight, this.fontsize});
  final String textname;
  final Color? color;
  final double? fontsize;

  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textname,
            style: TextStyle(color: color, fontSize: fontsize, fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}

class greenContainer extends StatelessWidget {
  const greenContainer({Key? key, required this.buttonName}) : super(key: key);
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.075,
        // height: MediaQuery.of(context).size.height * 0.04,

        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          buttonName,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
        )),
      ),
    );
  }
}

Future<void> selectDate(BuildContext context) async {
  final AuthController login = Get.find();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Color(0xff111A2C), // body text color
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1880, 8),
      lastDate: DateTime.now());
  if (picked != null && picked != login.selectedDate) {
    login.dobController.text = DateFormat('dd/MM/yyyy').format(picked);
    log(login.dobController.text); //formatted date output using intl package =>  2021-03-16

    login.userDateOfBirth = picked;
  } else {
    log("Date is not selected");
    //setState(() => selectedDate = picked ?? "");
  }
}

class ObsecureIcon extends StatelessWidget {
  const ObsecureIcon({Key? key, required this.isVisible, required this.onTap}) : super(key: key);

  final bool isVisible;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        isVisible ? Icons.visibility_off : Icons.visibility,
        color: isVisible ? Colors.green : Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
