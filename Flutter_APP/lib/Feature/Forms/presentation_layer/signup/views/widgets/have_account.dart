import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Feature/Forms/presentation_layer/SignIn/views/LogIn.dart';

import '../../../../../../colors/colors.dart';


class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "HaveAnAccount?".tr,
        style: const TextStyle(color: Colors.black, fontFamily: kPrimaryFont),
        children: [
          TextSpan(
            text: "login".tr,
            style: TextStyle(color: primary_color, fontFamily: kPrimaryFont),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
          )
        ],
      ),
    );
  }
}
