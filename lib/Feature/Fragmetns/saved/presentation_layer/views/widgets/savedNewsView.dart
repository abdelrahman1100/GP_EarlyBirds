import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Core/Messages/toast_message.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/presentation_layer/views/widgets/saveItemView.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/presentation_layer/views/widgets/unSaved.dart';
import '../../../../../News/Data_layer/Models/news_model.dart';
import '../../../../../News/presentation_layer/views/widgets/news_item.dart';
import 'no_item_saved.dart';

class savedItemViews extends StatefulWidget {
  savedItemViews({super.key, required this.savedNews});

  List<news_model> savedNews;

  @override
  State<savedItemViews> createState() => _savedItemViewsState();
}

class _savedItemViewsState extends State<savedItemViews> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: widget.savedNews.length,
        (context, index) {
          return Dismissible(
            onDismissed: (direction) {
              setState(() {
                widget.savedNews.removeAt(index);
              });
            },
            confirmDismiss: (DismissDirection direction) {
              if(direction == DismissDirection.endToStart) {
                return showDialog(
                  context: context,
                  builder: (context) =>
                      unSaved(articleId: widget.savedNews[index].id));
              }else {
                return showDialog(
                  context: context,
                  builder: (context) =>
                      unSaved(articleId: widget.savedNews[index].id));
              }
            },
            background: Container(
              color: Colors.transparent,
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Container(
                margin: const EdgeInsets.only(right: 32),
                // alignment: Alignment.center,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text('delete'.tr, style: const TextStyle(color: Colors.white, fontFamily: kPrimaryFont),)
                  ],
                ),
              ),
            ),
            key: ValueKey<news_model>(widget.savedNews[index]),
            child: savedItemView(
              model: widget.savedNews[index],
            ),
          );
        },
      ),
    );
  }
}
