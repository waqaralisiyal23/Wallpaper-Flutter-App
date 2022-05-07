import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appBar(String title, {double fontSize = 28.0}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(fontSize: fontSize),
    ),
    elevation: 0.0,
    centerTitle: true,
  );
}

Widget titleHeading(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
    ),
  );
}

void showSnackbar(String title, String msg, Icon icon,
    {backgroundColor = Colors.red}) {
  Get.snackbar(
    title,
    msg,
    margin: const EdgeInsets.all(16.0),
    backgroundColor: backgroundColor == Colors.red
        ? Colors.red.withOpacity(0.7)
        : backgroundColor,
    colorText: Colors.white,
    icon: icon,
    shouldIconPulse: false,
  );
}
