import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';

import '../../../../../../colors/colors.dart';
import '../../../signup/views/Signup.dart';

class dontHaveAccount extends StatelessWidget {
  const dontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don'tHaveAnAccount".tr,
        style: const TextStyle(color: Colors.black, fontFamily: kPrimaryFont),
        children: [
          TextSpan(
            text: "signup".tr,
            style: TextStyle(color: primary_color, fontFamily: kPrimaryFont),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Signup()));
              },
          )
        ],
      ),
    );
  }
}
