import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Forms/presentation_layer/components /TextComp.dart';
import 'item_model.dart';

class items_list extends StatelessWidget {
  items_list({super.key, required this.item});

  item_model item;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:24.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(item.Category_image),
        TextComp(message: item.Category_name, message_color: Colors.white, size: 16)
      ],),
    );
  }
}
