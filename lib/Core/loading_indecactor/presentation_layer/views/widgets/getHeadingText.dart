import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';

class getHeadingText extends StatelessWidget {
  const getHeadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          'Please wait …',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            fontFamily: kPrimaryFont
          ),
          textAlign: TextAlign.center,
        )
    );;
  }
}
