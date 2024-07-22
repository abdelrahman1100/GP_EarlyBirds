import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Feature/comments%20/data_layer/model/commentModel.dart';
import 'package:gp_east_news/colors/colors.dart';

class commentItemView extends StatelessWidget {
   commentItemView({super.key, required this.model});
  commentModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: primary_color),
        borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: Column(

          children: [
             Text(model.author, style: const TextStyle(color:Colors.black, fontFamily: kPrimaryFont),),
             const SizedBox(height: 4,),
             Text(model.text, style: const TextStyle(color:Colors.black,),maxLines: 2,),
        ],
      ),
    );
  }
}
