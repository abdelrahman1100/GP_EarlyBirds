
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Feature/Fragmetns/settings/presentation_layer/views/widgets/Setteing_item_component.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../colors/colors.dart';

class setting_fragment extends StatelessWidget {
  const setting_fragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'settings'.tr,
              style: TextStyle(
                  color: primary_color, fontFamily: kPrimaryFont, fontSize: 32),
            ),
            const SizedBox(height: 20),
            setteingItemComponent(
              text: 'language'.tr,
              icon: Ionicons.earth_outline,
              color: Colors.redAccent,
              list:  ["english".tr, "arabic".tr],
              currentValue: 'English',
            ),
          ],
        ),
      ),
    );
  }
}
