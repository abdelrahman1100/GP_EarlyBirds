import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/News/presentation_layer/views/news_details.dart';
import 'package:gp_east_news/colors/colors.dart';

class savedItemView extends StatelessWidget {
  savedItemView({super.key, required this.model});

  news_model model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> news_details(item: model)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: primary_color)),
          child: Row(
            children: [
              Image.network(
                model.image ?? defualtImage,
                width: 100,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  model.title ?? "title",
                  style: const TextStyle(
                      fontFamily: kPrimaryFont, color: Colors.black, fontSize: 12),
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
