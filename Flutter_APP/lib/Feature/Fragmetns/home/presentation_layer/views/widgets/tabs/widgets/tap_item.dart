import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';

class tap_item extends StatelessWidget {
  tap_item({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      style: const TextStyle(
          fontFamily: kPrimaryFont, fontSize: 12,),
    );
  }
}
