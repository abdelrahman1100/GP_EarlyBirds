import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Core/app_rounded_blur.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/comments%20/data_layer/model/commentModel.dart';

import '../../../data_layer/Api/commets.dart';
import '../comments_view.dart';

class commentItemComponent extends StatefulWidget {
   commentItemComponent({super.key, required this.model});
   news_model model;
  @override
  State<commentItemComponent> createState() => _commentItemComponentState();
}

class _commentItemComponentState extends State<commentItemComponent> {

  late List<commentModel> commentList;
  late int commentsNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppRoundedButtonBlur(
          icon: const Icon(Icons.add_comment, color: Colors.white,),
          onTap: () async{
            commentList = await Comments(Dio()).getComment(articleId:  widget.model.id);
            log("list comment Size: ${commentList.length}");
            setState(() {
              widget.model.comments = commentList.length;
            });
            showBottomSheet(
              elevation: 16,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: DraggableScrollableSheet(
                    maxChildSize: .5,
                    initialChildSize: .5,
                    minChildSize: .2,
                    builder: (context, scrollController) {
                      return commentView(commentsList: commentList,model: widget.model,);
                    },
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(width: 8,),
        Text(widget.model.comments.toString(), style: const TextStyle(color: Colors.white, fontFamily: kPrimaryFont),),
      ],
    );
  }
}
