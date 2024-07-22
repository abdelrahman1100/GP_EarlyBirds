import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Api/news_servieces/news_scervices.dart';
import 'package:gp_east_news/Feature/News/presentation_layer/views/news_list.dart';
import 'package:gp_east_news/colors/colors.dart';

class getNewsResonse extends StatefulWidget {
  getNewsResonse({super.key, required this.categoryName});

  String categoryName;

  @override
  State<getNewsResonse> createState() => _getNewsResonseState();
}

class _getNewsResonseState extends State<getNewsResonse> {
  var future;
  final pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = NewsServieces(Dio()).getNews(categoryName: widget.categoryName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<news_model>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return news_list(list_news: snapshot.data!,screen: 0,);
        } else if (snapshot.hasError) {
          return const Text("Error found");
        } else {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                color: primary_color,
              ),
            ),
          );
        }
      },
    );
  }
}
