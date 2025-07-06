
import 'package:flutter/material.dart';
import '../../../../colors/colors.dart';
import 'widgets/Profile_body.dart';
import 'widgets/Profile_header.dart';

class user_profile extends StatelessWidget {
  user_profile({super.key,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_color,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              profile_header(
              )
            ];
          },
          body: Profile_body(
          )),
    );
  }
}
