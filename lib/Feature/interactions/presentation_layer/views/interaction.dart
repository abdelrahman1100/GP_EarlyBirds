import 'package:flutter/material.dart';

import 'package:gp_east_news/Core/Messages/toast_message.dart';
import 'package:gp_east_news/Core/app_rounded_blur.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/presentation_layer/views/saved_fragment.dart';
import 'package:gp_east_news/Feature/comments%20/presentatio_layer/view/comments_view.dart';
import 'package:gp_east_news/Feature/comments%20/presentatio_layer/view/widgets/comment_icon_component.dart';
import 'package:gp_east_news/Feature/interactions%20/presentation_layer/views/widgets/like_component.dart';
import 'package:gp_east_news/Feature/interactions%20/presentation_layer/views/widgets/saved_item_icon_compontent.dart';

import '../../../News/Data_layer/Models/news_model.dart';

class intreaction extends StatefulWidget {
  intreaction({super.key, required this.model});

  news_model model;

  @override
  State<intreaction> createState() => _intreactionState();
}

class _intreactionState extends State<intreaction> {
  IconData bookMark = Icons.bookmark_add;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          likeComponent(
            model: widget.model
          ),
          commentItemComponent(
            model: widget.model,
          ),
        ],
      ),
    );
  }
}
