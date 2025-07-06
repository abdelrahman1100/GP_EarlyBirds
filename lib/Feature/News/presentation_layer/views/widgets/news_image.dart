import 'package:flutter/material.dart';

import '../../../../../colors/colors.dart';

class news_image extends StatelessWidget {
  news_image({super.key, required this.image});

  String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primary_color,
          ),
          child: Image.network(image, fit: BoxFit.cover,),
        ),
      ],
    );
  }
}
