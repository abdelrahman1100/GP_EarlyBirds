import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/presentation_layer/views/widgets/getSavedNews.dart';


class saved_fragment extends StatelessWidget {
  saved_fragment({super.key,});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          getSavedNews(),
        ],
      ),
    );
  }
}



