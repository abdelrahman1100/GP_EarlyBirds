import 'dart:ui';

import 'package:flutter/material.dart';


class AppRoundedButtonBlur extends StatelessWidget {
  final Function()? onTap;
  final Icon icon;
  const AppRoundedButtonBlur({Key? key, this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(56),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(56),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(56),
            onTap: onTap,
            child: SizedBox(
              width: 50,
              height: 50,
              child: icon
            ),
          ),
        ),
      ),
    );
  }
}