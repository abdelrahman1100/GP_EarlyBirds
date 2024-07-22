import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:gp_east_news/Core/Messages/toast_message.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class newsContentView extends StatelessWidget {
   newsContentView({super.key, required this.item});
  news_model item;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
        ),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(12),
            child: item.content == null? TextButton(
              child: Text(item.url!, style: const TextStyle(color: Colors.blue),
               ),
              onPressed: ()async{
                await openArticleUrl();
              },
            ) :

            Text(
              item.content!,
              style: const TextStyle(
                  color: Colors.black, fontFamily: kPrimaryFont),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openArticleUrl() async {
     final url = Uri.parse(item.url!);
    if(await canLaunchUrl(url)){
      await(launchUrl(url));
    }else{
      ToastMessage().showMessage(message: 'Some thing wrong');
    }
  }
}
