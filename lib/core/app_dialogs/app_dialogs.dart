import 'package:ecommerce_app/core/base_state/base_state.dart';
import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';

abstract class AppDialogs {
  static bool _isLoading = false;
  static void showLoading() {
    if (_isLoading == false) {
      _isLoading = true;
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            title: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ).then(
        (value) {
          _isLoading = false;
        },
      );
    }
  }

  static void hideLoading() {
    if (_isLoading == true) {
      Navigator.pop(navigatorKey.currentContext!);
      _isLoading = false;
    }
  }

  static void showToast(
      {required String message, ToastType type = ToastType.success}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == ToastType.success ? Colors.green : Colors.red,
      ),
    );
  }
}

enum ToastType { success, error }
