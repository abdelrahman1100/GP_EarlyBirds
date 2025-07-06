
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/interactions%20/data_layer/Api/likedpostmodel.dart';

import '../../../../../Core/app_rounded_blur.dart';
import '../../../data_layer/Api/liked.dart';


class likeComponent extends StatefulWidget {
   likeComponent({super.key, required this.model});
    news_model model;
  @override
  State<likeComponent> createState() => _likeComponentState();
}

class _likeComponentState extends State<likeComponent> {
   likesPostModel model = likesPostModel(likes: 0, statue: 'liked');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.likes = widget.model.likes;
  }
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      AppRoundedButtonBlur(
        icon: widget.model.isLiked
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(Icons.favorite, color: Colors.white),
        onTap: ()async{
           model = await Likes(Dio()).postLike(articleID: widget.model.id);
          setState(() {
            widget.model.likes = model.likes;
            if(model.statue == 'liked'){
               widget.model.isLiked = true;
            }else{
              widget.model.isLiked = false;
            }
          });
        },
      ),
      const SizedBox(width: 8,),
      Text(
        widget.model.likes.toString(),
        style: const TextStyle(color:Colors.white, fontFamily: kPrimaryFont),
      ),
    ],);
  }
}
