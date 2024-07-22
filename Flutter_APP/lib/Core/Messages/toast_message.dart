import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../colors/colors.dart';

class ToastMessage {
  void showMessage({required String message}) {
    Fluttertoast.showToast(
      backgroundColor: primary_color,
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showErrorMessage({required String message}) {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
