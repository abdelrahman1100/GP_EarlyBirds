
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';

class TextComp extends StatelessWidget {
  TextComp({super.key, required this.message, required this.message_color, required this.size});

  String message;
  Color message_color;
  double size = 16;
  @override
  Widget build(BuildContext context) {
    return  Text(
        message,
        style: TextStyle(
            color: message_color,
            fontSize: size,
            fontFamily: kPrimaryFont
        ),
    );
  }
}
