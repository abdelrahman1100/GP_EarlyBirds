import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/colors/colors.dart';

class getLoadingIndicator extends StatelessWidget {
  const getLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 32,
      width: 32,
      child:  CircularProgressIndicator(
        color: primary_color,
      ),
    );
  }
}
