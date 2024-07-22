import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/News/presentation_layer/views/news_details.dart';
import '../../../../../Core/Assets/assets_data.dart';
import '../../../../../colors/colors.dart';
import '../../../../interactions /presentation_layer/views/interaction.dart';
import '../../../Data_layer/Models/news_model.dart';
import 'news_image.dart';

class news_item extends StatelessWidget {
  news_item({super.key, required this.item,});
  news_model item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primary_color,
        border: Border.all(color: primary_color),
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
      ),
      child: Column(
        children: [
          GestureDetector(onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => news_details(item: item,),));
          }, child: news_image(image: item.image??defualtImage)),

          const SizedBox(
            height: 12,
          ),

           Container(
             alignment: Alignment.center,
             margin: const EdgeInsets.symmetric(horizontal: 8),
             child: Text(
               textAlign: TextAlign.center,
              item.title?? ' ',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:  const TextStyle(color: Colors.white, fontFamily: kPrimaryFont ),
                       ),
           ),

          intreaction(model: item,),
        ],
      ),
    );
  }
}
