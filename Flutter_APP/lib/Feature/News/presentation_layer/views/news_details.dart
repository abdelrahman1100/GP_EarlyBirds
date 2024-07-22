import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/Fragmetns/home/presentation_layer/views/home.dart';
import 'package:gp_east_news/Feature/News/presentation_layer/views/widgets/newe_content_view.dart';
import 'package:gp_east_news/Feature/News/presentation_layer/views/widgets/news_row_interactions.dart';
import 'package:gp_east_news/Feature/News/presentation_layer/views/widgets/news_sliver_app_bar.dart';
import '../../../../colors/colors.dart';
import '../../Data_layer/Models/news_model.dart';

class news_details extends StatelessWidget {
  news_details({super.key, required this.item, this.is_comment,});
  news_model item;
  bool? is_comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_color,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            newsSliverAppBar(item: item,),

            newsRowIneractions(item: item),

            newsContentView(item: item),
          ],
        ),
      ),
    );
  }
}
