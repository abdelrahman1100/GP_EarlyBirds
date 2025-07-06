import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';

class Profile_body extends StatelessWidget {
   Profile_body({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: user_model.Mail,
                  suffixIcon: const Icon(Icons.mail)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
