import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  static bool isLoaderShow = false;

  void showLoader() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    if (!isLoaderShow) {
      isLoaderShow = true;
      Get.dialog(
        WillPopScope(
            onWillPop: () => Future.value(false),
            child: const Center(child: CircularProgressIndicator())),
        barrierDismissible: false,
      );
    }
  }

  Future<void> dismissLoader() async {
    if (Get.isSnackbarOpen) {
      await Future.delayed(const Duration(seconds: 1));
      dismissLoader();
      return;
    }
    if (isLoaderShow) {
      isLoaderShow = false;
      if (Get.isSnackbarOpen) {
        Get.back();
      }
      Get.back();
    }
  }

  void showError(
      {String title = "Alert!", String? msg, bool isDialogNotDismiss = false}) {
    if (!isDialogNotDismiss) {
      dismissLoader();
    }
    if (msg != null) {
      Get.snackbar(title.tr, msg,
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white);
    }
  }

  void showSnack({String title = "Alert!", required String msg}) {
    dismissLoader();
    Get.snackbar(
      title.tr,
      msg,
      backgroundColor: const Color(0xff098a09),
      colorText: Colors.white,
    );
  }
}
