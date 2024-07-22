
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';

class loginWittGoogle extends StatelessWidget {
  const loginWittGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 12.0,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/Images/google.png'),
              const Text(
                'Sing up with google',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: kPrimaryFont,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
