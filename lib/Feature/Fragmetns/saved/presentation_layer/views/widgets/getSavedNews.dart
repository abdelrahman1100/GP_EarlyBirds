import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/data_layer/Api/Saved_news.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/presentation_layer/views/widgets/savedNewsView.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import '../../../../../../colors/colors.dart';


class getSavedNews extends StatefulWidget {
  getSavedNews({super.key});

  @override
  State<getSavedNews> createState() => _getSavedNewsState();
}

class _getSavedNewsState extends State<getSavedNews> {
  var future;
  final pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = SavedNews(Dio()).getSavedNews(userId: user_model.id);
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
          return savedItemViews(
            savedNews: snapshot.data!,
          );
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