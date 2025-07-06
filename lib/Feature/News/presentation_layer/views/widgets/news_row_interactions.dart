import 'package:flutter/cupertino.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/atricle_reader/presentation_layer/view/audoi.dart';

import '../../../../comments /presentatio_layer/view/widgets/comment_icon_component.dart';
import '../../../../interactions /presentation_layer/views/widgets/like_component.dart';
import '../../../../interactions /presentation_layer/views/widgets/saved_item_icon_compontent.dart';
import '../../../../summary/presentation_layer/views/widgets/summary_icon_component.dart';

class newsRowIneractions extends StatelessWidget {
   newsRowIneractions({super.key, required this.item});
  news_model item;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            likeComponent(model: item,),
            commentItemComponent(model: item,),
            savedItemIcon(model: item,),
            selectedLang == 'en' ? summaryIconComponent(content: item.content??'content'):const Text(''),
            selectedLang == 'en' ?  AudoiIcon(model: item):const Text(''),
          ],
        ),
      ),
    );
  }
}
