import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Api/news_servieces/get_news_response.dart';

class FragementBody extends StatefulWidget {
  FragementBody({super.key, required this.category});

  String category;

  @override
  State<FragementBody> createState() => _FragementBodyState();
}

class _FragementBodyState extends State<FragementBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          getNewsResonse(categoryName: widget.category),
        ],
      ),
    );
  }
}
