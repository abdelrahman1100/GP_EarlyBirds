import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Core/Messages/toast_message.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';
import 'package:gp_east_news/Feature/comments%20/data_layer/Api/deletComment.dart';
import 'package:gp_east_news/Feature/comments%20/data_layer/Api/editComment.dart';
import 'package:gp_east_news/Feature/comments%20/presentatio_layer/view/widgets/comment_item_view.dart';
import '../../../data_layer/model/commentModel.dart';

class commentListView extends StatefulWidget {
  commentListView({super.key, required this.list});

  List<commentModel> list;

  @override
  State<commentListView> createState() => _commentListViewState();
}

class _commentListViewState extends State<commentListView> {
  TextEditingController newCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return user_model.id == widget.list[index].authorId
            ? Slidable(
          child: commentItemView(
            model: widget.list[index],
          ),
          startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                icon: Icons.edit,
                label: 'Edit',
                backgroundColor: Colors.blue,
                onPressed: (context) async {
                  await edit(
                      context, widget.list[index].id, widget.list[index].text, index);
                },
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                icon: Icons.delete,
                label: 'delete'.tr,
                backgroundColor: Colors.red,
                onPressed: (context) async {
                  bool result = await delete(context, widget.list[index].id,
                      widget.list[index].authorId);
                  log("controller: ${newCommentController.text}");
                  if (result) {
                    setState(() {
                      widget.list.removeAt(index);
                    });
                    ToastMessage().showMessage(message: "Comment deleted");
                  }
                },
              ),
            ],
          ),
        )
            : SingleChildScrollView(
            child: commentItemView(
              model: widget.list[index],
            ));
      },
    );
  }

  Future<bool> delete(BuildContext context, String commentID,
      String authorID) async {
    bool res = await DeleteComment(Dio()).delete(
        authorId: authorID, commentId: commentID);
    return res;
  }

  Future<void> edit(BuildContext context, String commentID, String text, int index) async {
    newCommentController.text = text;
    bool res = false;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text('Edit comment'.tr,
              style: const TextStyle(fontFamily: kPrimaryFont),),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: newCommentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment'.tr,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      if (newCommentController.text.isNotEmpty) {
                        res = await EditComment(Dio()).edit(
                            text: newCommentController.text,
                            commentId: commentID);
                        if(res){
                          setState(() {
                            widget.list[index].text = newCommentController.text;
                          });
                          ToastMessage().showMessage(message: 'Comment Edit'.tr);
                        }
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}
