
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';

import '../../../../colors/colors.dart';




class Button extends StatefulWidget {
   Button({super.key, required this.title, required this.backgroundColor, required this.onPress});

  String title;
  Color backgroundColor;
  final void Function() onPress;
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: MaterialButton(
        color: primary_color,
        onPressed: widget.onPress,
        child:  Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
           widget.title,
            style: const TextStyle(
                color: Colors.white, fontFamily: kPrimaryFont, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
