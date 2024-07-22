
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Forms/presentation_layer/components /TextComp.dart';
import '../../../Main/Presentation_layer/views/mainScreen.dart';
import '../../../../colors/colors.dart';
import 'widgets/item_model.dart';
import 'widgets/items_list.dart';


class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary_color,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Image.asset('assets/Images/SeletedCategory.png',),
            const SizedBox(height: 24,),
            TextComp(
                message: 'SHARE WITH US YOUR INTEREST',
                message_color: Colors.white,
                size: 16),
            items_list(
              item: item_model(
                  Category_image: 'assets/Images/sports.png',
                  Category_name: 'sports'.tr),
            ),
            items_list(
              item: item_model(
                  Category_image: 'assets/Images/Politics.png',
                  Category_name: 'entertainment'.tr),
            ),
            items_list(
              item: item_model(
                  Category_image: 'assets/Images/Science.png',
                  Category_name: 'science'.tr),
            ),
            items_list(
              item: item_model(
                  Category_image: 'assets/Images/technology.png',
                  Category_name: 'technology'.tr),
            ),
            items_list(
              item: item_model(
                  Category_image: 'assets/Images/Business.png',
                  Category_name: 'business'.tr),
            ),
            const SizedBox(height: 24,),
            GestureDetector(
                onTap: () {
                  tap = true;
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => main_screen(current_fragmnet_index: 0,)));
                },
                child: !tap ? const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                    size: 48
                ) : const CircularProgressIndicator()

            ),
          ],
        ));
  }
}
