import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {

static SnackbarController error(String title, String subTitle, {int seconds = 5, String position = "TOP"}) {
  return Get.snackbar(
      title,
      subTitle,
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
      backgroundColor: Colors.red,
      duration: Duration(seconds: seconds),

      snackPosition: position == "TOP"? SnackPosition.TOP : SnackPosition.BOTTOM);
}

static SnackbarController success(String title, String subTitle, {int seconds = 5, String position = "TOP"}) {
    return Get.snackbar(
        title,
        subTitle,
        colorText: Colors.white,
        icon: Icon(Icons.check_circle, color: Colors.white),
        backgroundColor: Colors.green,
        duration: Duration(seconds: seconds),
        snackPosition: position == "TOP"? SnackPosition.TOP : SnackPosition.BOTTOM);
}


}