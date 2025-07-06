
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/main.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../Main/Presentation_layer/views/mainScreen.dart';


class setteingItemComponent extends StatefulWidget {
  setteingItemComponent(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.list,
      required this.currentValue});

  List<String> list;
  String text;
  IoniconsData icon;
  Color color;
  String currentValue;

  @override
  State<setteingItemComponent> createState() => _State();
}

class _State extends State<setteingItemComponent> {
  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.color),
          child: Icon(widget.icon, color: Colors.white),
        ),
        title: Text(
          widget.text,
          style: TextStyle(color: widget.color, fontFamily: kPrimaryFont, fontSize: 12),
        ),
        trailing:  Container(
          decoration:  BoxDecoration(
            color: widget.color
          ),
          child: DropdownMenu<String>(
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(widget.color)
            ),
            textStyle:
                const TextStyle(color: Colors.white, fontFamily: kPrimaryFont),
            initialSelection: selectedLang  == 'ar' ? widget.list[1] : widget.list[0],
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedLang = value == 'arabic'.tr ? 'ar' : 'en';
                widget.currentValue = value == 'arabic'.tr ? 'ar' : 'en';
              });
              Get.updateLocale(Locale(selectedLang));
            },
            dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>(
              (String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
