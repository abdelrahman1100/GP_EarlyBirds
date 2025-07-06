import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Core/Messages/toast_message.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/comments%20/data_layer/Api/postComment.dart';
import 'package:gp_east_news/Feature/comments%20/presentatio_layer/view/widgets/commentsListView.dart';
import 'package:gp_east_news/colors/colors.dart';
import '../../data_layer/model/commentModel.dart';

class commentView extends StatefulWidget {
  commentView({super.key, required this.commentsList, required this.model});

  final news_model model;
  final List<commentModel> commentsList;

  @override
  State<commentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<commentView> {
  final comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Text('Comments'.tr, textAlign: TextAlign.center,style: const TextStyle(fontFamily: kPrimaryFont),),
            Container(
              margin: const EdgeInsets.only(top: 8,bottom: 16),
              color: primary_color,
              height: 3,
              width: 100,
              alignment: Alignment.center,
            ),
            Expanded(
              child: commentListView(
                list: widget.commentsList,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                        hintText: 'Add a comment'.tr,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (comment.text.isNotEmpty) {
                        if(comment.text.contains('nigger') || comment.text.contains('shit')){
                           Future.delayed(const Duration(seconds:  2),(){
                             ToastMessage().showErrorMessage(message: "This is offensive comment");
                             comment.clear();
                             Focus.of(context).unfocus();
                           });
                        }else{
                          commentModel newComment = await postComment(Dio())
                              .post(text: comment.text, articleId: widget.model.id);
                          comment.clear();
                          setState(() {
                            widget.commentsList.add(newComment);
                            widget.model.comments++;
                          });
                        }
                      }
                      Focus.of(context).unfocus();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
