import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Top_Bar extends StatelessWidget {
  const Top_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff03416E),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'E'.tr,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'FasterOne',
                fontWeight: FontWeight.normal,
                fontSize: 40),
          ),
          Text(
            'AST NEWS'.tr,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Alatsi',
                fontWeight: FontWeight.normal,
                fontSize: 40),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Image(
              image: AssetImage('assets/logo/logo64.png'),
            ),
          ),
        ],
      ),
    );
  }
}
