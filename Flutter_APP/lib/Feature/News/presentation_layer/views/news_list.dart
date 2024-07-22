import 'package:flutter/cupertino.dart';
import '../../Data_layer/Models/news_model.dart';
import 'widgets/news_item.dart';

class news_list extends StatelessWidget {
  news_list({super.key, required this.list_news, required this.screen});
  int screen;
  List<news_model> list_news;
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate:  SliverChildBuilderDelegate(
          childCount: list_news.length,
            (context,index){
               return news_item(item: list_news[index],);
            }
        )
    );
  }
}
