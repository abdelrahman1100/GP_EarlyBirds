import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import '../../../../Forms/presentation_layer/SignIn/views/LogIn.dart';
import '../../../../../colors/colors.dart';

class logoutDialog extends StatelessWidget {
  const logoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.logout),
      title:  Text('logout'.tr, style: const TextStyle(fontFamily: kPrimaryFont),),
      content:
       Text('logoutMessage'.tr, textAlign: TextAlign.center, style: const TextStyle(fontFamily: kPrimaryFont)),
      actions: [
        TextButton(onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
          );
        },child:  Text('logout'.tr, style: TextStyle(fontFamily: kPrimaryFont, color: primary_color),),),
      ],
    );
  }
}
