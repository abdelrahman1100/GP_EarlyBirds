import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Core/ConstantKeies/ConstKey.dart';
import '../../../../../colors/colors.dart';
import '../../components /Top_Bar.dart';
import 'widgets/LoginForm.dart';
import '../../components /TextComp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Top_Bar(),
            TextButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setBool(constKey.onBoaring, false);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 32),
                child: TextComp(
                  message: "welcome to east news".tr,
                  message_color: Colors.black,
                  size: 16,
                ),
              ),
            ),
            const Loginform(),
          ],
        ),
      ),
    );
  }
}
