import 'package:flutter/material.dart';
import 'package:gp_east_news/Feature/Fragmetns/home/presentation_layer/views/widgets/tabs/widgets/tab_scroll_view.dart';
import 'package:gp_east_news/Feature/Fragmetns/Fragement_body.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(-8),
              child: tabScrollView(),
            ),
          ),
          body:  TabBarView(
            children: [
              FragementBody(category: 'entertainment',),
              FragementBody(category: 'sports',),
              FragementBody(category: 'business',),
              FragementBody(category: 'science',),
              FragementBody(category:'technology' ,),
              FragementBody(category: 'entertainment',),
              FragementBody(category: 'health',),
            ],
          ),),
    );
  }
}
