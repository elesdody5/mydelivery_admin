import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var roundedButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Get.theme.primaryColor))));

InputDecoration formInputDecoration(
        {String? label, Widget? suffixIcon, String? suffixText}) =>
    InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Get.theme.primaryIconTheme.color!),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Get.theme.primaryIconTheme.color!),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Get.theme.primaryIconTheme.color!),
      ),
    );
