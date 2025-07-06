import 'package:flutter/material.dart';
import 'package:gp_east_news/colors/colors.dart';

import '../presentation_layer/views/showLoadingIndecator.dart';




class dialogs {
  void showLodaingDialog(
      {required String text, required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        content: showLoadingIndecator(
          text: text,
        ),
        backgroundColor: Colors.black87.withOpacity(0.8),
      ),
    );
  }


  void ShowErrorDialog(BuildContext context, String code) {
    showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        backgroundColor: Colors.red,
        title: const Text('Error', style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
        content: Text(code.substring(7,code.length - 1), style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
      ),
    );
  }
}
